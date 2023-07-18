terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region 
  access_key = var.access_key 
  secret_key = var.secret_key 
}

provider "null" {
}