  region               = "us-east-1"
vpc_id               = "vpc-68f96212"
  broker_name       = "example-rabbitmq"
  engine_version    = "3.13"
  host_instance_type = "mq.t5.large"
  security_group_name   = "sg-example-rabbitmq"
  subnet_ids        = ["subnet-6781cb49"]
  user_username     = "exampleuser"
  user_password     = "example@123password"
  enable_logging    = true