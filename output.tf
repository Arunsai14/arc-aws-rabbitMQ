output "security_group_id" {
  description = "The ID of the created security group for brokerMQ."
  value       = aws_security_group.this.id
}

output "rabbitmq_user_password_ssm_parameter" {
  description = "The SSM parameter storing the RabbitMQ user password."
  value       = aws_ssm_parameter.rabbitmq_user_password.name
}

output "rabbitmq_user_ssm_parameter" {
  description = "The SSM parameter storing the RabbitMQ username."
  value       = aws_ssm_parameter.rabbitmq_user.name
}

output "replication_user_password_ssm_parameter" {
  description = "The SSM parameter storing the replication user password for ActiveMQ."
  value       = var.broker_type == "ActiveMQ" ? aws_ssm_parameter.replication_user_password[0].name : null
}

output "rabbitmq_broker_id" {
  description = "The ID of the RabbitMQ broker."
  value       = var.broker_type == "RabbitMQ" ? aws_mq_broker.rabbit-mq[0].id : null
}

output "activemq_broker_id" {
  description = "The ID of the ActiveMQ broker."
  value       = var.broker_type == "ActiveMQ" ? aws_mq_broker.active-mq[0].id : null
}

