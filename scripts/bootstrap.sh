#!/bin/bash

# Variables to use in bash sctipt
region="eu-central-1"
bucket_name="devops-challenge-tfstate"

# Create S3 storage bucket for the Terraform state
aws s3 mb s3://$bucket_name --region $region