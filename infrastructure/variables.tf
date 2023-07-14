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
    cidr_block       = string
    instance_tenancy = string
    tags             = map(string)
  })
}


# Subnet related variables
variable "subnet" {
  type = object({
    cidr_block       = string
    tags             = map(string)
  })
}


# ec2 instance related variables
variable "ec2" {
  type = list(object({
    name                   = string
    instance_type          = string
    monitoring             = bool
    tags                   = map(string)
  }))
}