# DevOps Challenge

## The Project

Deploy a phone validator app with a frontend and a backend using AWS EC2 instances
with Terraform and Ansible

## AWS Infrastructure

- VPC with subnets
- Security groups
- NAT gateway
- EC2 instance for the load balancer running Nginx as a reverse proxy
- EC2 instance for the database that runs PostgreSQL
- EC2 instance for the Ansible control node
- EC2 instance for the microservice that hosts the frontend and backend

## How the deployment works

- The repository contains as validator-fronted and a validator-backend which each have their own Dockerfile
- The images are build and pushed to AWS ECR using the GitHub action
- Terraform is then triggered to initialize, validate, plan and apply the infrastructure
- During the Terraform run it calls on Ansible to bootstrap the Ansible control node
- During the Terraform run it also connects to the Ansible control node and configures the rest of the EC2 instances


## Requirements to deploy this from your local machine

- You will need to have an AWS Account and generate an access key
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
- The AWS keys can be set as environment variables for Terraform to use:
  - TF_VAR_access_key
  - TF_VAR_secret_key
- You will need to have AWS CLI installed locally on your machine
- You will need to have Terraform installed locally on your machine

## How the bootstrap script works

- Creates a AWS S3 storage bucket for the Terraform remote state
- Creates the path to store the SSH keys for each instance
- Creates SSH Key pairs for each instance and stores them in the created path

## How Terraform creates the infrastructure

- Create a VPC with private and public subnets
- Create a NAT gateway for the private subnets for internal breakout
- Create security groups for each instance to allow specific ports and also to allow egress traffic
- Create an EC2 instance that will be used for the Ansible control node
  - Create a Public IP address and Private IP address on public subnet
- Create an EC2 instance that will be used for the Nginx load balancer
  - Create a Public IP address and Private IP address on public subnet
- Create an EC2 instance that will be used for the microservices running docker
  - Create a private IP address on private subnet
  - Create a IAM role policy that allows the microservice access to ECR resources
- Create an EC2 instance that will be used for the database running PostgreSQL
  - Create a private IP address on private subnet

## How Terraform is used to bootstrap Ansible and configure the worker instances

- Run a remote-exec against the Ansible control instance which will return "Connected" once the instance \
  is up and accepting an SSH connection
- Run a local-exec from Terraform to the Ansible control node to bootstrap it with Ansible using Ansible and \
  configure it by copying all the required [worker instance files](https://github.com/edwardpullen/devops_challenge/tree/main/infrastructure/ansible/config) onto the Ansible control instance
  - This step is required to allow the next steps to run from the Ansible control instance to configure the \
    rest of the instances as they only have private IP addresses
- Run a remote-exec to connect to the Ansible control instance and run the playbook on the control instance to \
  configure the load balancer with Nginx and configure the reverse proxy for the API path
- Run a remote-exec to connect to the Ansible control instance and run the playbook on the control instance to \
  configure the database with Postgres, create a database and user and import the sample database sql file
- Run a remote-exec to connect to the Ansible control instance and run the playbook on the control instance to \
  configure microservice by installing Docker, pulling the images for frontend and backend from ECR and running them
- Here is the location of the [Ansible bootstrap](https://github.com/edwardpullen/devops_challenge/tree/main/infrastructure/ansible_bootstrap.tf) for reference

## How the load balancer and microservices communication works

- Frontend is running on port 80 and listening on port 8081
- Backend is running on port 8080 and listening on port 8080
- Load balancer is configured to listed on port 80 and uses path based routing
  - Any requests on ```/``` will be routed to the frontend on port 8081
  - Any request on ```/api/v1/*``` will be routed to the backend on port 8080

## How the variables are defined

- The approach taken here is to store the variables for each module or resource in the form of an object instead \
  of having each variable separate which allows you to determine easily which variable is used for which module \
  or resource and is more human readable that having each variable separately defined. An example can be seen below

```terraform

module "vpc_devops_challenge" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = ["${var.region}a"]
  public_subnets  = var.vpc.public_subnets
  private_subnets = var.vpc.private_subnets

  enable_nat_gateway = var.vpc.enable_nat_gateway
  enable_vpn_gateway = var.vpc.enable_vpn_gateway

  tags = var.vpc.tags
}

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

```

- The variable values are not stored in the variable.tf file but instead use [variables.tfvars](https://github.com/edwardpullen/devops_challenge/tree/main/environment/variables.tfvars) as can be seen below

```terraform
vpc = {
  name               = "devops-challenge"
  cidr               = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24"]
  private_subnets    = ["10.0.2.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = false
  
  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}
```

- The above way of storing variables separate from the [variables.tf](https://github.com/edwardpullen/devops_challenge/tree/main/infrastrucutre/variables.tf) file allows for easy deployment if you where \
  to deploy another environment like staging or production.

## How the Deployment process works

1. Clone the repository to your local machine
2. You will need to build and push the images to ECR 
   1. Frontend image needs to be named ```validator-frontend``` using ```latest``` tag
   2. Backend image needs to be named ```validator-backend``` using ```latest``` tag
3. Change the region and bucket name in the [bootstrap.sh](https://github.com/edwardpullen/devops_challenge/blob/main/scripts/bootstrap.sh) script
4. Run the [bootstrap.sh](https://github.com/edwardpullen/devops_challenge/blob/main/scripts/bootstrap.sh)
5. Update the [backend.conf](https://github.com/edwardpullen/devops_challenge/blob/main/environment/backend.conf) bucket, key and region
6. Update the [variables.tfvars](https://github.com/edwardpullen/devops_challenge/tree/main/environment/variables.tfvars) with your ```region```
7. Change directory so that you are in the Terraform [infrastructure] location
8. Initialize the Terraform providers and modules: ```terraform init -backend-config=../environment/backend.conf```
9. Validate the Terraform code: ```terraform validate```
10. Run a plan to see what resources will be created: ```terraform plan --var-file=../environment/variables.tfvars```
11. Run a apply to create the resources: ```terraform apply```
