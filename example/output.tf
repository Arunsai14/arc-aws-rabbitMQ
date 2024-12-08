output "security_group_id" {
  description = "The ID of the security group created for the MQ broker."
  value       = module.mq_broker.security_group_id
}
output "rabbitmq_user_password_ssm_parameter" {
  description = "The SSM parameter name storing the RabbitMQ user password."
  value       = module.mq_broker.broker_mq_user_password_ssm_parameter
}

output "rabbitmq_user_ssm_parameter" {
  description = "The SSM parameter name storing the RabbitMQ username."
  value       = module.mq_broker.broker_mq_user_ssm_parameter
}

output "replication_user_password_ssm_parameter" {
  description = "The SSM parameter name storing the replication user password (ActiveMQ only)."
  value       = module.mq_broker.replication_user_password_ssm_parameter
}

output "rabbitmq_broker_id" {
  description = "The ID of the RabbitMQ broker (if broker_type is RabbitMQ)."
  value       = module.mq_broker.rabbitmq_broker_id
}
output "activemq_broker_id" {
  description = "The ID of the ActiveMQ broker (if broker_type is ActiveMQ)."
  value       = module.mq_broker.activemq_broker_id
}


