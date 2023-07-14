# Create a VPC
resource "aws_vpc" "vpc_devops_challenge" {
  cidr_block       = var.vpc.cidr_block
  instance_tenancy = var.vpc.instance_tenancy

  tags = var.vpc.tags
}