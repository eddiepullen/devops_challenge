#!/bin/bash

# Variables to use in sctipt
region="eu-central-1"
key_path="../infrastructure/ansible/config/keys/"
bucket_name="devops-challenge-tfstate"

# Declare an array of SSH keys
keys=("ansible-ssh-key lb-ssh-key db-ssh-key")
                   
# Create S3 storage bucket for the Terraform state
aws s3 mb s3://$bucket_name --region $region

# Create SSH key pairs
for key in ${keys[@]}; do
  aws ec2 create-key-pair --key-name $key --key-type rsa \
  --key-format pem --region $region --query 'KeyMaterial' \
  --output text > $key_path$key.pem
done

chmod 400 $key_path/* 