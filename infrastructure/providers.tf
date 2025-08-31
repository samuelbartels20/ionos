terraform {
  required_version = ">= 1.5.0"

  required_providers {
    # IONOS Cloud Provider
    ionoscloud = {
      source  = "ionos-cloud/ionoscloud"
      version = "~> 6.5.0"
    }
    
    # Random Provider
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    # Helm Provider
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.0"
    }
    # Kubernetes Provider
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24.0"
    }
    # TLS Provider
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.0"
    }
    
    # Local Provider
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
    # OnePassword Provider
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 2.1.2"
    }
    # AWS Provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }

  }

} 