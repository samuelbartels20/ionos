terraform {
  backend "s3" {
    bucket                      = "ionos202030"
    key                         = "terraform.tfstate"
    region                      = "us-east-1"
    skip_credentials_validation = true
  }
}

module "onepassword_ionos" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = data.onepassword_vault.K8s.name
  item   = "ionos"
}

# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  username = module.onepassword_ionos.fields["IONOS_USERNAME"]
  password = module.onepassword_ionos.fields["IONOS_PASSWORD"]
  endpoint = module.onepassword_ionos.fields["IONOS_ENDPOINT"]
  token    = module.onepassword_ionos.fields["IONOS_TOKEN"]
}

provider "onepassword" {
  service_account_token = var.op_service_account_token
}

provider "aws" {
  region = "us-east-1"
}