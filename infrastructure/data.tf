# Datasource to retrieve the AMI image to be used
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "local_file" "ansible_key" {
  filename = "${path.module}/ansible/config/keys/ansible-ssh-key.pem"
}