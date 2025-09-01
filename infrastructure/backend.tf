terraform {
  backend "s3" {
    bucket                      = "my-terraform-state-bucket-ankah-2025"
    key                         = "terraform.tfstate"
    region                      = "us-east-1"
    skip_credentials_validation = true
  }
}

# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  username = var.ionos_username
  password = var.ionos_password
  endpoint = var.ionos_endpoint
  token    = var.ionos_token
}

provider "onepassword" {
  service_account_token = var.op_service_account_token
}

provider "aws" {
  region = "us-east-1"
}