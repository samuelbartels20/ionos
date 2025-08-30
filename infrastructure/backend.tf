terraform {
  required_version = ">= 1.5.0"
  # Configure the S3 backend
  
  backend "s3" {
    bucket = "ionos202030"
    key    = "terraform.tfstate"
    region = "us-east-1"
    
    # No special settings needed for AWS S3
    # Just set these environment variables:
    # export AWS_ACCESS_KEY_ID="your-aws-access-key"
    # export AWS_SECRET_ACCESS_KEY="your-aws-secret-key"
  }
}

provider "aws" {
  region = "us-east-1"
}


# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  endpoint = var.ionos_endpoint
  token = var.ionos_token
  username = var.ionos_username
  password = var.ionos_password
}

provider "onepassword" {
  url                   = var.op_connect_host
  token                 = var.op_connect_token
  service_account_token = var.op_connect_service_account_token
  account               = var.op_connect_account
  op_cli_path           = var.op_connect_cli_path
}