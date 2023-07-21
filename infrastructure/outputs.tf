output "load_balancer_http" {
  value = "http://${module.lb_ec2_instance.public_ip}"
}