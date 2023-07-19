# Deploy ansible control instance
module "ansible_instance" {
  source   = "terraform-aws-modules/ec2-instance/aws"

  name                        = var.ansible_instance.name
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = var.ansible_instance.key_name
  instance_type               = var.ansible_instance.instance_type
  monitoring                  = var.ansible_instance.monitoring
  associate_public_ip_address = var.ansible_instance.associate_public_ip_address
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [module.lb_security_group.security_group_id]
  subnet_id                   = element(module.vpc_devops_challenge.public_subnets, 0)
  # subnet_id                   = element(module.vpc_devops_challenge.private_subnets, 0)
  private_ip                  = var.ansible_instance.private_ip

  tags = var.ansible_instance.tags
}

# Deploy load balancer instance
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
  private_ip                  = var.lb_ec2_instance.private_ip


  tags = var.lb_ec2_instance.tags
}

# Deploy microservice instance
module "microservice_ec2_instance" {
  source   = "terraform-aws-modules/ec2-instance/aws"

  name                        = var.microservice_ec2_instance.name
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = var.microservice_ec2_instance.key_name
  instance_type               = var.microservice_ec2_instance.instance_type
  monitoring                  = var.microservice_ec2_instance.monitoring
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [module.microservice_security_group.security_group_id]
  subnet_id                   = element(module.vpc_devops_challenge.private_subnets, 0)
  private_ip                  = var.microservice_ec2_instance.private_ip

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance to access ECR"
  iam_role_policies = {
    AmazonEC2ContainerRegistryFullAccess = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
    AmazonEC2ContainerServiceforEC2Role  = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  }

  tags = var.microservice_ec2_instance.tags
}

# Deploy database instance
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
  subnet_id                   = element(module.vpc_devops_challenge.private_subnets, 0)
  private_ip                  = var.db_ec2_instance.private_ip
}