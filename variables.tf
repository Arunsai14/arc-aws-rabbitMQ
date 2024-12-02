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

variable "security_groups" {
  description = "List of security group IDs for the RabbitMQ broker."
  type        = list(string)
  default     = []
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
  default     = false
}

variable "user_username" {
  description = "Username for the RabbitMQ broker."
  type        = string
}

variable "user_password" {
  description = "Password for the RabbitMQ broker."
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


