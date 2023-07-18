region     = "eu-central-1"

# AWS provider variables
# access_key = ""
# secret_key = ""

# Ansible SSH private key
# ansible_private_key = ""

# VPC related variables
vpc = {
  name               = "devops-challenge"
  cidr               = "10.0.0.0/16"
  public_subnets    = ["10.0.1.0/24"]
  enable_nat_gateway = false
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

ansible_security_group_ingress = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
]

ansible_security_group_egress = [
  {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = "0.0.0.0/0"
  }
]

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
  },
  {
    from_port   = 22
    to_port     = 22
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
ansible_instance = {
  name                        = "ansible"
  instance_type               = "t2.micro"
  key_name                    = "ansible-ssh-key"
  private_ip                  = "10.0.1.5"
  monitoring                  = true
  associate_public_ip_address = true
  tags = {
    terraform   = "true"
    environment = "production"
    trigger     = true
  }
}

lb_ec2_instance = {
  name                        = "load-balancer"
  instance_type               = "t2.micro"
  key_name                    = "lb-ssh-key"
  private_ip                  = "10.0.1.10"
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
  private_ip                  = "10.0.1.15"
  monitoring                  = true
  associate_public_ip_address = false
  tags = {   
    terraform   = "true"
    environment = "production"
  }
}