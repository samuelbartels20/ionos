terraform {  
  backend "s3" {
    bucket = "ionos202030"
    key    = "terraform.tfstate"
    region = "us-east-1"
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