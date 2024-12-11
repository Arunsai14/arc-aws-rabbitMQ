locals {
  security_group_data = {
    create      = true
    description = "Security Group for brokerMQ"

    ingress_rules = [
      {
        description = "Allow VPC traffic"
        cidr_block  = data.aws_vpc.this.cidr_block
        from_port   = 0
        ip_protocol = "tcp"
        to_port     = 65535
      },
      {
        description = "Allow traffic from self"
        self        = true
        from_port   = 0
        ip_protocol = "tcp"
        to_port     = 65535
      },
      {
        description              = "Allow traffic from security group"
        source_security_group_id = data.aws_security_group.default.id
        from_port                = 0
        ip_protocol              = "tcp"
        to_port                  = 65535
      }
    ]

    egress_rules = [
      {
        description = "Allow all outbound traffic"
        cidr_block  = "0.0.0.0/0"
        from_port   = -1
        ip_protocol = "-1"
        to_port     = -1
      }
    ]
  }
}