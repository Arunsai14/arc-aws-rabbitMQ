terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

########### Security Group for brokerMQ ######### 
resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = "Security group for the brokerMQ"
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
  tags = var.tags
}

######### Generate a random password #########
resource "random_password" "rabbitmq_user_password" {
  length           = 32
  special          = true
  upper            = true
  lower            = true
  numeric          = true
  override_special = "!@#$%^&*()-_+<>?"
}

######### Store the generated password in ssm #########
resource "aws_ssm_parameter" "user_password" {
  name  = "/mq/broker/${var.namespace}/${var.environment}/user_password"
  type  = "SecureString"
  value = random_password.rabbitmq_user_password.result
}

resource "aws_ssm_parameter" "replication_user_password" {
  count              = var.broker_type == "ActiveMQ" ? 1 : 0
  name  = "/mq/broker/${var.namespace}/${var.environment}/replication_user_password"
  type  = "SecureString"
  value = random_password.rabbitmq_user_password.result
}

resource "aws_ssm_parameter" "user_name" {
  name  = "/mq/broker/${var.namespace}/${var.environment}/user_name"
  type  = "SecureString"
  value = var.users.username
}

resource "aws_ssm_parameter" "replication_user" {
  count              = var.broker_type == "ActiveMQ" ? 1 : 0
  name  = "/mq/broker/${var.namespace}/${var.environment}/replication_user_name"
  type  = "SecureString"
  value = var.users.username
}

########################################################################
#############################  RabiitMQ   ##############################
########################################################################

resource "aws_mq_broker" "rabbit-mq" {
  count              = var.broker_type == "RabbitMQ" ? 1 : 0
  broker_name        = var.broker_name
  engine_type        = var.broker_type
  engine_version     = var.engine_version
  host_instance_type = var.host_instance_type
  security_groups    = var.publicly_accessible ? null : [aws_security_group.this.id]
  subnet_ids         =  var.publicly_accessible ? null : var.subnet_ids
  publicly_accessible = var.publicly_accessible
  deployment_mode    = var.deployment_mode
  storage_type       = var.storage_type
  apply_immediately  = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade


  user {
    username = var.users.username
    password = aws_ssm_parameter.user_password.value
    groups   = var.users.groups

  }
  dynamic "logs" {
    for_each = var.enable_logging ? [1] : []
    content {
      general = true
    }
  }

encryption_options {
  use_aws_owned_key = var.encryption_options.use_aws_owned_key
  kms_key_id        = var.encryption_options.kms_key_id
}

maintenance_window_start_time {
  day_of_week = var.maintenance_window.day_of_week
  time_of_day = var.maintenance_window.time_of_day
  time_zone   = var.maintenance_window.time_zone
}

 tags = var.tags
}

########################################################################
########################  Apache ActiveMQ   ############################
########################################################################

resource "aws_mq_broker" "active-mq" {
  count              = var.broker_type == "ActiveMQ" ? 1 : 0
  broker_name        = var.broker_name
  engine_type        = var.broker_type
  engine_version     = var.engine_version
  host_instance_type = var.host_instance_type
  security_groups    = [aws_security_group.this.id]
  subnet_ids         = var.subnet_ids
  publicly_accessible = var.publicly_accessible
  deployment_mode    = var.deployment_mode
  storage_type       = var.storage_type
  apply_immediately  = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  
  user {
    username = var.users.username
    password = aws_ssm_parameter.user_password.value
    groups   = var.users.groups

  }
   user {
    username         = var.users_replica.replication_username
    password         = aws_ssm_parameter.replication_user_password[0].value
    groups   = var.users_replica.groups
    replication_user = true
  }


  dynamic "logs" {
    for_each = var.enable_logging ? [1] : []
    content {
      general = true
      audit   = true
    }
  }

  dynamic "data_replication" {
    for_each = var.enable_data_replication ? [1] : []
    content {
      data_replication_mode               = "CRDR"
      data_replication_primary_broker_arn = var.data_replication_primary_broker_arn
    }
  }

encryption_options {
  use_aws_owned_key = var.encryption_options.use_aws_owned_key
  kms_key_id        = var.encryption_options.kms_key_id
}

maintenance_window_start_time {
  day_of_week = var.maintenance_window.day_of_week
  time_of_day = var.maintenance_window.time_of_day
  time_zone   = var.maintenance_window.time_zone
}

   dynamic "ldap_server_metadata" {
    for_each = var.ldap_config.required ? [1] : []
    content {
      hosts                      = var.ldap_config.hosts
      role_base                  = var.ldap_config.role_base
      role_name                  = var.ldap_config.role_name
      role_search_matching       = var.ldap_config.role_search_matching
      role_search_subtree        = var.ldap_config.role_search_subtree
      service_account_password   = var.ldap_config.service_account_password
      service_account_username   = var.ldap_config.service_account_username
      user_base                  = var.ldap_config.user_base
      user_role_name             = var.ldap_config.user_role_name
      user_search_matching       = var.ldap_config.user_search_matching
      user_search_subtree        = var.ldap_config.user_search_subtree
    }
  }

 tags = var.tags
}