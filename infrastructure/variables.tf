# Common variables 
variable "region" {
  description = "AWS region where the provider will operate"
  type        = string
}

# AWS provider variables
variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "ansible_ssh_key" {
  description = "Ansible SSH key"
  type        = string
}

variable "database_name" {
  description = "Postgres databsae name}"
  type        = string
}

variable "database_user" {
  description = "Postgres databsae user"
  type        = string
}

variable "database_password" {
  description = "Postgres database password"
  type        = string
}


# VPC related variables
variable "vpc" {
  type = object({
    name               = string
    cidr               = string
    public_subnets     = list(string)
    private_subnets    = list(string)
    enable_nat_gateway = bool
    enable_vpn_gateway = bool
    tags               = map(string)
  })
}

# Security group related variables 
variable "ansible_security_group_ingress" {
  type = list
}

variable "ansible_security_group_egress" {
  type = list
}

variable "microservice_security_group_ingress" {
  type = list
}

variable "microservice_security_group_egress" {
  type = list
}

variable "lb_security_group_ingress" {
  type = list
}

variable "lb_security_group_egress" {
  type = list
}

variable "db_security_group_ingress" {
  type = list
}

variable "db_security_group_egress" {
  type = list
}


# ec2 instances related variables
variable "ansible_instance" {
  type = object({
    name                        = string
    instance_type               = string
    key_name                    = string
    private_ip                  = string
    monitoring                  = bool
    associate_public_ip_address = bool
    tags                        = map(string)
  })
}

variable "microservice_ec2_instance" {
  type = object({
    name                        = string
    instance_type               = string
    key_name                    = string
    private_ip                  = string
    monitoring                  = bool
    tags                        = map(string)
  })
}

variable "lb_ec2_instance" {
  type = object({
    name                        = string
    instance_type               = string
    key_name                    = string
    private_ip                  = string
    monitoring                  = bool
    associate_public_ip_address = bool
    tags                        = map(string)
  })
}

variable "db_ec2_instance" {
  type = object({
    name                        = string
    instance_type               = string
    key_name                    = string
    private_ip                  = string
    monitoring                  = bool
    associate_public_ip_address = bool
    tags                        = map(string)
  })
}