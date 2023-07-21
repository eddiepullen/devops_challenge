# AWS region
region     = "eu-central-1"

# AWS provider variables
# access_key = ""
# secret_key = ""

# Postgres database credentials
# database_name = ""
# database_user = ""
# database_password = ""

# Ansible control ssh key location
ansible_ssh_key = "./ansible/config/keys/ansible-ssh-key.pem"


# VPC related variables
vpc = {
  name               = "devops-challenge"
  cidr               = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24"]
  private_subnets    = ["10.0.2.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = false
  
  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}


# Security group related variables 
ansible_security_group_ingress = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 1337
    to_port     = 1337
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

microservice_security_group_ingress = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 8081
    to_port     = 8081
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

microservice_security_group_egress = [
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
    from_port   = 1337
    to_port     = 1337
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
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 1337
    to_port     = 1337
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


# EC2 instance related variables
ansible_instance = {
  name                        = "ansible"
  instance_type               = "t2.small"
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
  instance_type               = "t2.small"
  key_name                    = "lb-ssh-key"
  private_ip                  = "10.0.1.10"
  monitoring                  = true
  associate_public_ip_address = true
  tags = {
    terraform   = "true"
    environment = "production"
  }
}

microservice_ec2_instance = {
  name                        = "microservice"
  instance_type               = "t2.small"
  key_name                    = "microservice-ssh-key"
  private_ip                  = "10.0.2.15"
  monitoring                  = true
  associate_public_ip_address = false
  tags = {
    terraform   = "true"
    environment = "production"
  }
}

db_ec2_instance = {
  name                        = "database"
  instance_type               = "t2.small"
  key_name                    = "db-ssh-key"
  private_ip                  = "10.0.2.20"
  monitoring                  = true
  associate_public_ip_address = false
  tags = {   
    terraform   = "true"
    environment = "production"
  }
}