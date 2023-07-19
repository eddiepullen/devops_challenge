# Use Terraform to bootstrap ansible control node by installing ansible
# and copying all the required ansible files for the workers to the ansible
# control node and then use Terraform to tell the control node to configure
# the worker nodes
resource "null_resource" "my_instance" {

  triggers = {
    # Will run each time there is a change to this instance.
    # instance_ids = module.ansible_instance.id
    
    # Will run every time
    time = timestamp()
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./ansible/config/keys/ansible-ssh-key.pem")
      host        = module.ansible_instance.public_ip
    }
    
    inline = ["echo 'connected!'"]
  }

  provisioner "local-exec" {
    command = "ansible-playbook --private-key=./ansible/config/keys/ansible-ssh-key.pem --ssh-common-args='-o StrictHostKeyChecking=no' ./ansible/config/master.yaml -u ubuntu -i '${module.ansible_instance.public_ip},' "
  }

  # provisioner "remote-exec" {
  #   connection {  
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file("${path.module}/ansible/config/keys/ansible-ssh-key.pem")
  #     host        = module.ansible_instance.public_ip
  #   }
    
  #   inline = ["ansible-playbook -i ~/ansible/hosts ~/ansible/playbooks/lb.yaml --ssh-common-args='-o StrictHostKeyChecking=no'"]
  # }

  # provisioner "remote-exec" {
  #   connection {  
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file("${path.module}/ansible/config/keys/ansible-ssh-key.pem")
  #     host        = module.ansible_instance.public_ip
  #   }
    
  #   inline = ["ansible-playbook -i ~/ansible/hosts ~/ansible/playbooks/microservice.yaml --ssh-common-args='-o StrictHostKeyChecking=no'"]
  # }

  # provisioner "remote-exec" {
  #   connection {  
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file("${path.module}/ansible/config/keys/ansible-ssh-key.pem")
  #     host        = module.ansible_instance.public_ip
  #   }
    
  #   inline = ["ansible-playbook -i ~/ansible/hosts ~/ansible/playbooks/db.yaml --ssh-common-args='-o StrictHostKeyChecking=no'"]
  # }
}