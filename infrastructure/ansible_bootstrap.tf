# Use Terraform to bootstrap ansible control node by installing ansible
# and copying all the required ansible files for the workers to the ansible
# control node and then use Terraform to tell the control node to configure
# the worker nodes and pull and run the images from ECR on the microservice
resource "null_resource" "my_instance" {
  triggers = {
    # Will run each time there is a change to this instance.
    # instance_ids = module.ansible_instance.id
    
    # Will run every time
    time = timestamp()
  }
  # Connect to ansible control instance to to check if ssh connection is ready
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ansible_ssh_key)
      host        = module.ansible_instance.public_ip
    }

    inline = ["echo 'connected!'"]
  }
  # Run ansible against the ansible control node and bootstrap it with ansible and required worker config
  provisioner "local-exec" {
    command = "ansible-playbook --private-key=${path.module}/ansible/config/keys/ansible-ssh-key.pem --ssh-common-args='-o StrictHostKeyChecking=no' ./ansible/config/master.yaml -u ubuntu -i '${module.ansible_instance.public_ip},' "
  }

  # Tell control node to run ansible against the lb and configure it
  provisioner "remote-exec" {
    connection {  
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ansible_ssh_key)
      host        = module.ansible_instance.public_ip
    }
    
    inline = ["ansible-playbook -i ~/ansible/hosts ~/ansible/playbooks/lb.yaml --ssh-common-args='-o StrictHostKeyChecking=no'"]
  }
  
  # Tell ansible control node to  run against db and configure it
  provisioner "remote-exec" {
    connection {  
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ansible_ssh_key)
      host        = module.ansible_instance.public_ip
    }
    
    inline = ["ansible-playbook -i ~/ansible/hosts ~/ansible/playbooks/db.yaml --extra-vars 'database_name=${var.database_name} database_user=${var.database_user} database_password=${var.database_password}' --ssh-common-args='-o StrictHostKeyChecking=no'"]
  }
  
  # Tell ansible control node to run against microservice and configure it, pull and run the imgaes
  provisioner "remote-exec" {
    connection {  
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ansible_ssh_key)
      host        = module.ansible_instance.public_ip
    }
    
    inline = ["ansible-playbook -i ~/ansible/hosts ~/ansible/playbooks/microservice.yaml --ssh-common-args='-o StrictHostKeyChecking=no'"]
  }
}