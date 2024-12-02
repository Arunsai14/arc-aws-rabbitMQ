terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
}
module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.5"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "aws rabbitMQ"
  }
}

########### Security Group for rabbitMQ ######### 
resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = "Security group for the rabbitMQ"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
  tags = merge(
    module.terraform-aws-arc-tags.tags
  )
}
resource "aws_mq_broker" "rabbitmq" {
  broker_name        = var.broker_name
  engine_type        = "RabbitMQ"
  engine_version     = var.engine_version
  host_instance_type = var.host_instance_type
  security_groups    = [aws_security_group.this.id]
  subnet_ids         = var.subnet_ids
  publicly_accessible = var.publicly_accessible
  deployment_mode    = var.deployment_mode
  storage_type       = var.storage_type
  apply_immediately  = var.apply_immediately

  user {
    username = var.user_username
    password = var.user_password
  }

  dynamic "logs" {
    for_each = var.enable_logging ? [1] : []
    content {
      general = true
    }
  }

  encryption_options {
    use_aws_owned_key = var.use_aws_owned_key
    kms_key_id        = var.kms_key_id
  }

  maintenance_window_start_time {
    day_of_week = var.maintenance_day
    time_of_day = var.maintenance_time
    time_zone   = var.maintenance_time_zone
  }

 tags = merge(
    module.terraform-aws-arc-tags.tags
  )
}