#   region               = "us-east-1"
#   vpc_id               = "vpc-68f96212"
#   broker_name       = "example-rabbitmq"
#   broker_type       = "RabbitMQ"
#   engine_version    = "3.13"
#   host_instance_type = "mq.m5.large"
#   deployment_mode    = "CLUSTER_MULTI_AZ"
#   security_group_name   = "sg-example-rabbitmq"
# #    subnet_ids        = ["subnet-6781cb49"]
#   subnet_ids        = ["subnet-6781cb49", "subnet-f55c1392"]
#   user_username     = "exampleuser"
#   user_password     = "example@123password"
#   enable_logging    = true
#   publicly_accessible =true
#   storage_type      = "ebs"

#   ingress_rules = [
#   {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   },
#   {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# ]

# egress_rules = [
#   {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1" # "-1" allows all protocols
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# ]