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


# VPC related variables
variable "vpc" {
  type = object({
    name               = string
    cidr               = string
    public_subnets     = list(string)
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