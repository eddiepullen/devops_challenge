# Create a VPC
module "vpc_devops_challenge" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = ["${var.region}a"]
  private_subnets = var.vpc.private_subnets
  public_subnets  = var.vpc.public_subnets

  enable_nat_gateway = var.vpc.enable_nat_gateway
  enable_vpn_gateway = var.vpc.enable_vpn_gateway

  tags = var.vpc.tags
}