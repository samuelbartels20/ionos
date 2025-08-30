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



# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  endpoint = var.ionos_endpoint
  token = var.ionos_token
  username = var.ionos_username
  password = var.ionos_password
}

provider "onepassword" {

    
}