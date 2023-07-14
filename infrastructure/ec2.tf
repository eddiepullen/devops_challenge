locals {
  # Create a map of the vpc instances
  ec2_instance_map = tomap({ for instance in var.ec2 :
    instance.name => instance
  })
}

module "ec2_instance" {
  source   = "terraform-aws-modules/ec2-instance/aws"
  for_each = local.ec2_instance_map

  name                   = each.value.name
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value.instance_type
  monitoring             = each.value.monitoring
  subnet_id              = aws_subnet.subnet_devops_challenge.id

  tags = each.value.tags
}