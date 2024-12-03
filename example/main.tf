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

module "mq_broker" {
  source           = "../"
  broker_name      = var.broker_name
  broker_type      = var.broker_type
  engine_version   = var.engine_version
  host_instance_type = var.host_instance_type
  subnet_ids       = var.subnet_ids
  publicly_accessible = var.publicly_accessible
  deployment_mode  = var.deployment_mode
  storage_type     = var.storage_type
  apply_immediately = var.apply_immediately
  user_username    = var.user_username
  enable_logging   = var.enable_logging
  use_aws_owned_key = var.use_aws_owned_key
  ingress_rules    = var.ingress_rules
  egress_rules     = var.egress_rules
  tags             = merge(
    module.terraform-aws-arc-tags.tags
  )

}