variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"  # Change as needed
}

variable "environment" {
  type        = string
  description = "Name of the environment, i.e. dev, stage, prod"
  default     = "dev"
}

variable "namespace" {
  type        = string
  default     = "arc"
  description = "Namespace of the project, i.e. arc"
}

variable "subnet_names" {
  type        = list(string)
  description = "List of subnet names to lookup"
  default     = ["arc-poc-private-subnet-private-us-east-1a", "arc-poc-private-subnet-private-us-east-1b"]
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC to add the resources"
  default     = "arc-poc-vpc"
}


variable "project_name" {
  type        = string
  default     = "sourcefuse"
  description = "Project name"
}

variable "broker_type" {
  description = "Specify the broker type: RabbitMQ or ActiveMQ"
  type        = string
  default     = "RabbitMQ" 
}

variable "broker_name" {
  description = "Name of the RabbitMQ broker."
  type        = string
}

variable "engine_version" {
  description = "Version of the RabbitMQ engine."
  type        = string
  default     = "3.8.26"
}

variable "host_instance_type" {
  description = "Instance type for the RabbitMQ broker."
  type        = string
  default     = "mq.t3.micro"
}

# variable "subnet_ids" {
#   description = "List of subnet IDs for the RabbitMQ broker."
#   type        = list(string)
#   default     = []
# }

variable "publicly_accessible" {
  description = "Whether the RabbitMQ broker is publicly accessible."
  type        = bool
  default     = false
}

variable "deployment_mode" {
  description = "Deployment mode for the RabbitMQ broker."
  type        = string
  default     = "SINGLE_INSTANCE"
}

variable "storage_type" {
  description = "Storage type for the RabbitMQ broker."
  type        = string
  default     = "ebs"
}

variable "apply_immediately" {
  description = "Whether changes should be applied immediately."
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "enable_logging" {
  description = "Enable general logging for the RabbitMQ broker."
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates whether minor engine upgrades are applied automatically to the instance during the maintenance window."
  type        = bool
  default     = true
}

variable "encryption_options" {
  description = "Encryption options for the resource."
  type = object({
    use_aws_owned_key = bool
    kms_key_id        = string
  })
  default = {
    use_aws_owned_key = true
    kms_key_id        = null
  }
}

variable "maintenance_window" {
  description = "Maintenance window configuration including day, time, and time zone."
  type = object({
    day_of_week = string
    time_of_day = string
    time_zone   = string
  })
  default = {
    day_of_week = "MONDAY"
    time_of_day = "02:00"
    time_zone   = "UTC"
  }
}

# variable "vpc_id" {
#   description = "The VPC ID for the VPC endpoint."
#   type        = string
#   default   = null
# }


variable "users" {
  description = "List of users for the ActiveMQ broker"
  type = object({
    username         = optional(string)
    groups           = optional(list(string), [])
  })
  default = {}
}

  variable "users_replica" {
  description = "List of users for the ActiveMQ broker"
  type = object({
    replication_username         = optional(string)
    groups           = optional(list(string), [])
  })
  default = {}
}

variable "enable_data_replication" {
  description = "Enable or disable data replication for the broker"
  type        = bool
  default     = false
}