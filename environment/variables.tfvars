region     = "eu-central-1"


# VPC related variables
vpc = {
  name               = "devops-challenge"
  cidr               = "10.0.0.0/16"
  private_subnets    = ["10.0.1.0/24"]
  public_subnets     = ["10.0.101.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = false
  
  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}

# Security group related variables
lb_security_group_ingress = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
]

lb_security_group_egress = [
  {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = "0.0.0.0/0"
  }
]

db_security_group_ingress = [
  {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
]

db_security_group_egress = [
  {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = "0.0.0.0/0"
  }
]

# ec2 instance related variables
lb_ec2_instance = {
  name                        = "load-balancer"
  instance_type               = "t2.micro"
  key_name                    = "lb-ssh-key"
  monitoring                  = true
  associate_public_ip_address = true
  tags = {
    terraform   = "true"
    environment = "production"
  }
}
  
db_ec2_instance = {
  name                        = "database"
  instance_type               = "t2.micro"
  key_name                    = "db-ssh-key"
  monitoring                  = true
  associate_public_ip_address = false
  tags = {   
    terraform   = "true"
    environment = "production"
  }
}