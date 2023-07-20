# Create a security group for the ansible cotrol instance
module "ansible_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ansible-security-group"
  vpc_id      = module.vpc_devops_challenge.vpc_id

  ingress_with_cidr_blocks = var.ansible_security_group_ingress
  egress_with_cidr_blocks  = var.ansible_security_group_egress
}

# Create a security group for the microservice instance
module "microservice_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "microservice-security-group"
  vpc_id      = module.vpc_devops_challenge.vpc_id

  ingress_with_cidr_blocks = var.microservice_security_group_ingress
  egress_with_cidr_blocks  = var.microservice_security_group_egress
}

# Create a security group for the load balancer instance
module "lb_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "lb-security-group"
  vpc_id      = module.vpc_devops_challenge.vpc_id

  ingress_with_cidr_blocks = var.lb_security_group_ingress
  egress_with_cidr_blocks  = var.lb_security_group_egress
}

# Create a security group for database instance
module "db_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "lb-security-group"
  vpc_id      = module.vpc_devops_challenge.vpc_id

  ingress_with_cidr_blocks = var.db_security_group_ingress
  egress_with_cidr_blocks  = var.db_security_group_egress
}