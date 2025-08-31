terraform {  
  backend "s3" {
    bucket = "ionos202030"
    key    = "terraform.tfstate"
    region = "us-east-1"
    # access_key = var.aws_access_key_id
    # secret_key = var.aws_secret_access_key
    skip_credentials_validation = true
  }
}

# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  username = data.onepassword_item.item.ionos_username
  password = data.onepassword_item.item.ionos_password
  endpoint = data.onepassword_item.item.ionos_endpoint
  token = data.onepassword_item.item.ionos_token
}

provider "onepassword" {
  service_account_token = var.op_service_account_token
}

provider "aws" {
  region = "us-east-1"
  # access_key = var.aws_access_key_id
  # secret_key = var.aws_secret_access_key
}