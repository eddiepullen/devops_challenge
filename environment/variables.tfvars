region     = "eu-central-1"


# VPC related variables
vpc = {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"
  tags = {
    name      = "vpc-devops-challenge"
    terraform = "true"
  } 
}


# Subnet related variables
subnet = {
  cidr_block  = "172.16.10.0/24"
  tags = {
    name        = "subnet-devops-challenge"
    terraform   = "true"
    environment = "production"
  }
}


# ec2 instance related variables
# Allows you to dynamically create additional ec2 instnaces only using configuration
ec2 = [
  {
    name           = "load-balancer"
    instance_type  = "t2.micro"
    monitoring     = true
    
    tags = {
      terraform   = "true"
      environment = "production"
    }
  },
  {
    name          = "database"
    instance_type = "t2.micro"
    monitoring    = true
    
    tags = {   
      terraform   = "true"
      environment = "production"
    }
  }
]