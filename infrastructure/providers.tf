terraform {
  required_version = ">= 1.0"

  required_providers {
    ionoscloud = {
      source  = "ionos-cloud/ionoscloud"
      version = "~> 6.4.0" # Check for the latest version
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
    }
  }
}

# Configure the IONOS Cloud Provider
provider "ionoscloud" {
  username = var.ionos_username
  password = var.ionos_password
}