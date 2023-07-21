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
- EC2 instance for the microservice that hosts the frontned and backened

## How this deployment works

- The repository contains as validator-frontned and a validator-backened which each have their own Dockerfile
- The images are build and pushed to AWS ECR using the GitHub action
- Terraform is then triggered to initialize, validate, plan and apaply the infrastrucutre
- During the Terraform run it calls on Ansible to bootstrap the Ansible control node
- During the Terraform run it also connects to the Ansible control node and configures the rest of the EC2 instances


## Requirments to deploy this from your local machine

- You will need to have an AWS Account and generate an access key
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
- The AWS keys can be stored as environment variables for Terraform to use:
  - TF_VAR_access_key
  - TF_VAR_secret_key
- You will need to have AWS CLI installed locally on your machine
- You will need to have Terraform installed locally on your machine

## How the bootsrap script works

- Creates a AWS S3 storage bucket for the Terraform remote state
- Creates the path to store the SSH keys for each instance
- Creates SSH Key pairs for each instance and stores them in the created path

## How the Terraform works to crreate the instructure

- Create a VPC with private and public subnets
- Create a NAT gateway for the private subnets for internal breakout
- Create security groups for each instance to allow spesific ports and also to allow egress traffic
- Create an EC2 instance that will be used for the Ansible control node
  - Create a Public IP address and Private IP address on public subnet
- Create an EC2 instance that will be used for the Nginx load balancer
  - Contais a Public IP address and Private IP address on public subnet
- Create an EC2 instance that will be used for the microserices running docker
  - Create a private IP address on private subnet
  - Create a IAM role policy that allows the microservice access to ECR resources
- Create an EC2 instance that will be used for the database running PostgreSQL
  - Create a private IP address on private subnet

## How the Terraform works to bootstrap Ansible and run it

- Run a remote-exec against the Ansbile control instance which will return "Connected" once the instance \
  is up and accepting an SSH connection
- Run a local-exec from Terraform to the Ansible control node to bootsrap it with Ansible using Ansible and \
  configure it by copying all the required [worker instance files](https://github.com/edwardpullen/devops_challenge/tree/main/infrastructure/ansible/config) onto the Ansible control instance
  - This step is required to allow the next steps to run from the Ansible control instance to configure the \
    rest of the instances as they only have private IP addresses
- Run a remote-exec to connect to the Ansible control instnace and run the playbook on the control instnce to \
  configure the load balancer with Nginx and configure the reverse proxy for the API path
- Run a remote-exec to connect to the Ansible control instnace and run the playbook on the control instnce to \
  configure the database with Postgres, create a database and user and import the sample database sql file
- Run a remote-exec to connect to the Ansible control instance and run the playbook on the control instance to \
  configure microservice by installing Docker, pulling the images for frontend and backend from ECR and running them

  
## How the Deployment process works

1. Clone the repositroy to your local machine
2. Run the [bootsrap.sh](https://github.com/edwardpullen/devops_challenge/blob/main/scripts/bootstrap.sh)

