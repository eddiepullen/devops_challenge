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
  private_ip                  = var.ansible_instance.private_ip

  tags = var.ansible_instance.tags
}

# Use Terraform to bootstrap ansible control node buy installing ansible
# and copying all the required ansible files for the workers to the ansible
# control node and then use Terraform to tell the control node to configure
# the worker nodes
resource "null_resource" "my_instance" {

  triggers = {
    instance_ids = module.ansible_instance.id
    # time = timestamp()
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/ansible/config/keys/ansible-ssh-key.pem")
      host        = module.ansible_instance.public_ip
    }
    
    inline = ["echo 'connected!'"]
  }

  provisioner "local-exec" {
    command = "ansible-playbook --private-key=${path.module}/ansible/config/keys/ansible-ssh-key.pem --ssh-common-args='-o StrictHostKeyChecking=no' ${path.module}/ansible/config/master.yaml -u ubuntu -i '${module.ansible_instance.public_ip},' "
  }

  provisioner "remote-exec" {
    connection {  
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/ansible/config/keys/ansible-ssh-key.pem")
      host        = module.ansible_instance.public_ip
    }
    
    inline = ["ansible-playbook -i ~/ansible/hosts ~/ansible/playbooks/lb.yaml --ssh-common-args='-o StrictHostKeyChecking=no'"]
  }
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
  subnet_id                   = element(module.vpc_devops_challenge.public_subnets, 0)
  private_ip                  = var.db_ec2_instance.private_ip
}