terraform {
  required_version = ">= 1.0"
  
  required_providers {
    ionoscloud = {
      source  = "ionos-cloud/ionoscloud"
      version = "~> 6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  backend "s3" {
    bucket   = var.bucket_name
    key      = var.key
    region   = var.region
    endpoint = var.endpoint
    
    access_key = var.access_key
    secret_key = var.secret_key
    
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style           = true
  }
}

provider "ionoscloud" {
  # Provider configuration will be read from environment variables
  # IONOS_USERNAME and IONOS_PASSWORD
}

# Random password for database
resource "random_password" "mysql_root_password" {
  length  = 16
  special = true
}

# Data Center
resource "ionoscloud_datacenter" "main" {
  name        = var.datacenter_name
  location    = var.datacenter_location
  description = "Production Kubernetes infrastructure"
}

# Kubernetes Cluster
resource "ionoscloud_k8s_cluster" "main" {
  name         = var.cluster_name
  k8s_version  = var.kubernetes_version
  location     = var.datacenter_location
  
  maintenance_window {
    day_of_the_week = var.maintenance_day
    time           = var.maintenance_time
  }

  api_subnet_allow_list = var.api_subnet_allow_list
  s3_buckets            = var.s3_buckets
}

# System Node Pool (for system workloads)
resource "ionoscloud_k8s_nodepool" "system" {
  datacenter_id  = ionoscloud_datacenter.main.id
  k8s_cluster_id = ionoscloud_k8s_cluster.main.id
  
  name        = "${var.cluster_name}-system"
  k8s_version = ionoscloud_k8s_cluster.main.k8s_version
  
  maintenance_window {
    day_of_the_week = var.maintenance_day
    time           = var.maintenance_time
  }
  
  auto_scaling {
    min_node_count = var.system_nodepool_min_nodes
    max_node_count = var.system_nodepool_max_nodes
  }
  
  cpu_family        = var.system_nodepool_cpu_family
  availability_zone = "AUTO"
  storage_type     = "SSD"
  storage_size     = var.system_nodepool_storage_size
  node_count       = var.system_nodepool_node_count
  cores_count      = var.system_nodepool_cores
  ram_size         = var.system_nodepool_ram
  
  labels = {
    "node-type" = "system"
    "workload"  = "system"
  }
  
  annotations = {
    "cluster.ionos.com/node-pool-type" = "system"
  }
}

# Application Node Pool (for application workloads)
resource "ionoscloud_k8s_nodepool" "application" {
  datacenter_id  = ionoscloud_datacenter.main.id
  k8s_cluster_id = ionoscloud_k8s_cluster.main.id
  
  name        = "${var.cluster_name}-application"
  k8s_version = ionoscloud_k8s_cluster.main.k8s_version
  
  maintenance_window {
    day_of_the_week = var.maintenance_day
    time           = var.maintenance_time
  }
  
  auto_scaling {
    min_node_count = var.app_nodepool_min_nodes
    max_node_count = var.app_nodepool_max_nodes
  }
  
  cpu_family        = var.app_nodepool_cpu_family
  availability_zone = "AUTO"
  storage_type     = "SSD"
  storage_size     = var.app_nodepool_storage_size
  node_count       = var.app_nodepool_node_count
  cores_count      = var.app_nodepool_cores
  ram_size         = var.app_nodepool_ram
  
  labels = {
    "node-type" = "application"
    "workload"  = "application"
  }
  
  annotations = {
    "cluster.ionos.com/node-pool-type" = "application"
  }
}

# Monitoring Node Pool (for observability workloads)
resource "ionoscloud_k8s_nodepool" "monitoring" {
  datacenter_id  = ionoscloud_datacenter.main.id
  k8s_cluster_id = ionoscloud_k8s_cluster.main.id
  
  name        = "${var.cluster_name}-monitoring"
  k8s_version = ionoscloud_k8s_cluster.main.k8s_version
  
  maintenance_window {
    day_of_the_week = var.maintenance_day
    time           = var.maintenance_time
  }
  
  auto_scaling {
    min_node_count = var.monitoring_nodepool_min_nodes
    max_node_count = var.monitoring_nodepool_max_nodes
  }
  
  cpu_family        = var.monitoring_nodepool_cpu_family
  availability_zone = "AUTO"
  storage_type     = "SSD"
  storage_size     = var.monitoring_nodepool_storage_size
  node_count       = var.monitoring_nodepool_node_count
  cores_count      = var.monitoring_nodepool_cores
  ram_size         = var.monitoring_nodepool_ram
  
  labels = {
    "node-type" = "monitoring"
    "workload"  = "monitoring"
  }
  
  annotations = {
    "cluster.ionos.com/node-pool-type" = "monitoring"
  }
}

# Configure Kubernetes provider
provider "kubernetes" {
  host                   = ionoscloud_k8s_cluster.main.kube_config.0.host
  token                  = ionoscloud_k8s_cluster.main.kube_config.0.token
  cluster_ca_certificate = base64decode(ionoscloud_k8s_cluster.main.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = ionoscloud_k8s_cluster.main.kube_config.0.host
    token                  = ionoscloud_k8s_cluster.main.kube_config.0.token
    cluster_ca_certificate = base64decode(ionoscloud_k8s_cluster.main.kube_config.0.cluster_ca_certificate)
  }
}

# Namespaces
resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
    labels = {
      "app.kubernetes.io/instance" = "flux-system"
      "app.kubernetes.io/part-of"  = "flux"
    }
  }
  
  depends_on = [ionoscloud_k8s_nodepool.system]
}

resource "kubernetes_namespace" "wordpress" {
  metadata {
    name = "wordpress"
    labels = {
      "app.kubernetes.io/name" = "wordpress"
    }
  }
  
  depends_on = [ionoscloud_k8s_nodepool.application]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      "app.kubernetes.io/name" = "monitoring"
    }
  }
  
  depends_on = [ionoscloud_k8s_nodepool.monitoring]
}

resource "kubernetes_namespace" "security" {
  metadata {
    name = "security"
    labels = {
      "app.kubernetes.io/name" = "security"
    }
  }
  
  depends_on = [ionoscloud_k8s_nodepool.system]
}

resource "kubernetes_namespace" "backup" {
  metadata {
    name = "backup"
    labels = {
      "app.kubernetes.io/name" = "backup"
    }
  }
  
  depends_on = [ionoscloud_k8s_nodepool.system]
}

# Storage Classes
resource "kubernetes_storage_class" "ssd" {
  metadata {
    name = "ionos-ssd"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }
  
  storage_provisioner    = "cloud.ionos.com/csi-driver"
  reclaim_policy         = "Retain"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true
  
  parameters = {
    "type" = "SSD"
  }
  
  depends_on = [ionoscloud_k8s_nodepool.system]
}

resource "kubernetes_storage_class" "hdd" {
  metadata {
    name = "ionos-hdd"
  }
  
  storage_provisioner    = "cloud.ionos.com/csi-driver"
  reclaim_policy         = "Retain"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true
  
  parameters = {
    "type" = "HDD"
  }
  
  depends_on = [ionoscloud_k8s_nodepool.system]
}

# Install Flux CD
resource "helm_release" "flux" {
  name       = "flux2"
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  version    = "2.12.1"
  namespace  = kubernetes_namespace.flux_system.metadata[0].name
  
  values = [
    yamlencode({
      installCRDs = true
      cli = {
        image = "ghcr.io/fluxcd/flux-cli:v2.2.2"
      }
      controllers = {
        source = {
          create = true
        }
        kustomize = {
          create = true
        }
        helm = {
          create = true
        }
        notification = {
          create = true
        }
        imageReflection = {
          create = true
        }
        imageAutomation = {
          create = true
        }
      }
      policies = {
        create = true
      }
      rbac = {
        create = true
      }
      multitenancy = {
        enabled = false
      }
    })
  ]
  
  depends_on = [kubernetes_namespace.flux_system]
}

# Create secret for Git repository access
resource "kubernetes_secret" "git_auth" {
  metadata {
    name      = "git-auth"
    namespace = kubernetes_namespace.flux_system.metadata[0].name
  }
  
  type = "Opaque"
  
  data = {
    "identity"     = var.git_private_key
    "identity.pub" = var.git_public_key
    "known_hosts"  = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
  }
  
  depends_on = [kubernetes_namespace.flux_system]
}

# Flux Git Source
resource "kubernetes_manifest" "git_source" {
  manifest = {
    apiVersion = "source.toolkit.fluxcd.io/v1"
    kind       = "GitRepository"
    metadata = {
      name      = "ionos-repo"
      namespace = kubernetes_namespace.flux_system.metadata[0].name
    }
    spec = {
      interval = "1m"
      ref = {
        branch = "main"
      }
      url = var.git_repository_url
      secretRef = {
        name = kubernetes_secret.git_auth.metadata[0].name
      }
    }
  }
  
  depends_on = [helm_release.flux, kubernetes_secret.git_auth]
}

# Flux Kustomization for infrastructure
resource "kubernetes_manifest" "flux_infrastructure" {
  manifest = {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1"
    kind       = "Kustomization"
    metadata = {
      name      = "infrastructure"
      namespace = kubernetes_namespace.flux_system.metadata[0].name
    }
    spec = {
      interval = "10m"
      path     = "./kubernetes/infrastructure"
      prune    = true
      sourceRef = {
        kind = "GitRepository"
        name = kubernetes_manifest.git_source.manifest.metadata.name
      }
      validation = "client"
      healthChecks = [
        {
          apiVersion = "apps/v1"
          kind       = "Deployment"
          name       = "cert-manager"
          namespace  = "cert-manager"
        }
      ]
    }
  }
  
  depends_on = [kubernetes_manifest.git_source]
}

# Flux Kustomization for applications
resource "kubernetes_manifest" "flux_applications" {
  manifest = {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1"
    kind       = "Kustomization"
    metadata = {
      name      = "applications"
      namespace = kubernetes_namespace.flux_system.metadata[0].name
    }
    spec = {
      interval = "10m"
      path     = "./kubernetes/applications"
      prune    = true
      sourceRef = {
        kind = "GitRepository"
        name = kubernetes_manifest.git_source.manifest.metadata.name
      }
      validation = "client"
      dependsOn = [
        {
          name = "infrastructure"
        }
      ]
    }
  }
  
  depends_on = [kubernetes_manifest.flux_infrastructure]
}

# Create kubeconfig file
resource "local_file" "kubeconfig" {
  content = yamlencode({
    apiVersion = "v1"
    kind       = "Config"
    clusters = [
      {
        name = ionoscloud_k8s_cluster.main.name
        cluster = {
          certificate-authority-data = ionoscloud_k8s_cluster.main.kube_config.0.cluster_ca_certificate
          server                     = ionoscloud_k8s_cluster.main.kube_config.0.host
        }
      }
    ]
    contexts = [
      {
        name = ionoscloud_k8s_cluster.main.name
        context = {
          cluster = ionoscloud_k8s_cluster.main.name
          user    = ionoscloud_k8s_cluster.main.name
        }
      }
    ]
    current-context = ionoscloud_k8s_cluster.main.name
    users = [
      {
        name = ionoscloud_k8s_cluster.main.name
        user = {
          token = ionoscloud_k8s_cluster.main.kube_config.0.token
        }
      }
    ]
  })
  
  filename        = "${path.module}/kubeconfig"
  file_permission = "0600"
  
  depends_on = [ionoscloud_k8s_cluster.main]
}