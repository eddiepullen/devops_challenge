module "lb_ec2_instance" {
  source   = "terraform-aws-modules/ec2-instance/aws"

  name                        = var.lb_ec2_instance.name
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = var.lb_ec2_instance.key_name
  instance_type               = var.lb_ec2_instance.instance_type
  monitoring                  = var.lb_ec2_instance.monitoring
  associate_public_ip_address = var.lb_ec2_instance.associate_public_ip_address
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [module.lb_security_group.security_group_id]
  subnet_id                   = element(module.vpc_devops_challenge.public_subnets, 0)

  tags = var.lb_ec2_instance.tags
}

module "db_ec2_instance" {
  source   = "terraform-aws-modules/ec2-instance/aws"

  name                        = var.db_ec2_instance.name
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = var.db_ec2_instance.key_name
  instance_type               = var.db_ec2_instance.instance_type
  monitoring                  = var.db_ec2_instance.monitoring
  associate_public_ip_address = var.db_ec2_instance.associate_public_ip_address
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [module.db_security_group.security_group_id]
  subnet_id                   = element(module.vpc_devops_challenge.public_subnets, 0)

  tags = var.db_ec2_instance.tags
}