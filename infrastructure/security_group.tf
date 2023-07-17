module "lb_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "lb-security-group"
  vpc_id      = module.vpc_devops_challenge.vpc_id

  ingress_with_cidr_blocks = var.lb_security_group_ingress
  egress_with_cidr_blocks  = var.lb_security_group_egress
}


module "db_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "lb-security-group"
  vpc_id      = module.vpc_devops_challenge.vpc_id

  ingress_with_cidr_blocks = var.db_security_group_ingress
  egress_with_cidr_blocks  = var.db_security_group_egress
}