terraform {
  required_version = ">= 1.5.0"
  # Configure the S3 backend
  backend "s3" {
    bucket = "ionos-wordpress"
    key    = "wordpress-infrastructure/terraform.tfstate"
    region = "de"
    # IONOS S3 endpoint
    endpoints = {
      s3 = "http://192.168.8.102:9000"
    }
    
    # Skip AWS-specific validations for IONOS compatibility
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style            = true
    
    # Set these as environment variables:
    # export AWS_ACCESS_KEY_ID="your-ionos-s3-access-key"
    # export AWS_SECRET_ACCESS_KEY="your-ionos-s3-secret-key"
  }
  #   backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "samuelbartels"

  #   workspaces {
  #     name = "ionos"
  #   }

  # }

}

# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  endpoint = data.onepassword_item.ionos_endpoint.IONOS_ENDPOINT
  token = data.onepassword_item.ionos_token.TF_VAR_IONOS_TOKEN
  username = data.onepassword_item.ionos_username.IONOS_USERNAME
  password = data.onepassword_item.ionos_password.IONOS_PASSWORD
}

provider "onepassword" {

}