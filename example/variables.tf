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

variable "subnet_ids" {
  description = "List of subnet IDs for the RabbitMQ broker."
  type        = list(string)
  default     = []
}

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

variable "username" {
  description = "Username for the RabbitMQ broker."
  type        = string
}

variable "replication_username" {
  description = "replication_username for the ActiveMQ broker."
  type        = string
}


variable "enable_logging" {
  description = "Enable general logging for the RabbitMQ broker."
  type        = bool
  default     = false
}

variable "use_aws_owned_key" {
  description = "Use AWS-owned KMS CMK for encryption."
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for encryption (if use_aws_owned_key is false)."
  type        = string
  default     = null
}

variable "maintenance_day" {
  description = "Day of the week for maintenance."
  type        = string
  default     = "MONDAY"
}

variable "maintenance_time" {
  description = "Time of day for maintenance in 24-hour format."
  type        = string
  default     = "02:00"
}

variable "maintenance_time_zone" {
  description = "Time zone for maintenance."
  type        = string
  default     = "UTC"
}

variable "vpc_id" {
  description = "The VPC ID for the VPC endpoint."
  type        = string
  default   = null
}

variable "ingress_rules" {
  description = "A list of ingress rules for the security group."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = []
}

variable "egress_rules" {
  description = "A list of egress rules for the security group."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = []
}


