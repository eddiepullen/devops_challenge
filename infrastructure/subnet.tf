# Create subnet
resource "aws_subnet" "subnet_devops_challenge" {
  vpc_id            = aws_vpc.vpc_devops_challenge.id
  cidr_block        = var.subnet.cidr_block
  availability_zone = "${var.region}a"

  tags = var.subnet.tags
}