terraform {  
  backend "s3" {
    bucket = "ionos202030"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  username = data.onepassword_item.IONOS_USERNAME.IONOS_USERNAME
  password = data.onepassword_item.IONOS_PASSWORD.IONOS_PASSWORD
}

provider "onepassword" {
  service_account_token = var.op_connect_service_account_token
}