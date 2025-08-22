
terraform {
  backend "s3" {
    bucket                      = "ionos-backend"
    key                         = "wordpress-platform/terraform.tfstate"
    region                      = "de"
    endpoint                    = "https://S3-eu-central-1.ionoscloud.com"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style           = true
  }
  
  required_providers {
    ionos = {
      source  = "ionos-cloud/ionos"
      version = "~> 6.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}