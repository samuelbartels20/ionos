# Datacenter Outputs
output "datacenter_id" {
  description = "The ID of the created datacenter"
  value       = ionoscloud_datacenter.main.id
}

output "datacenter_location" {
  description = "The location of the datacenter"
  value       = ionoscloud_datacenter.main.location
}

# Kubernetes Cluster Outputs
output "k8s_cluster_id" {
  description = "The ID of the created Kubernetes cluster"
  value       = ionoscloud_k8s_cluster.main.id
}

output "k8s_cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = ionoscloud_k8s_cluster.main.name
}

output "k8s_cluster_version" {
  description = "The version of the Kubernetes cluster"
  value       = ionoscloud_k8s_cluster.main.k8s_version
}

output "k8s_cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = ionoscloud_k8s_cluster.main.kube_config.0.host
  sensitive   = true
}

# Node Pool Outputs
output "system_nodepool_id" {
  description = "The ID of the system node pool"
  value       = ionoscloud_k8s_nodepool.system.id
}

output "application_nodepool_id" {
  description = "The ID of the application node pool"
  value       = ionoscloud_k8s_nodepool.application.id
}

output "monitoring_nodepool_id" {
  description = "The ID of the monitoring node pool"
  value       = ionoscloud_k8s_nodepool.monitoring.id
}

# Kubeconfig
output "k8s_cluster_kubeconfig" {
  description = "The kubeconfig for the Kubernetes cluster"
  value       = ionoscloud_k8s_cluster.main.kube_config
  sensitive   = true
}

output "kubeconfig_file_path" {
  description = "Path to the generated kubeconfig file"
  value       = local_file.kubeconfig.filename
}

# Database Password
output "mariadb_password" {
  description = "The password for MariaDB database"
  value       = random_password.mariadb_password.result
  sensitive   = true
}

# Cluster Information for Applications
output "cluster_info" {
  description = "Cluster information for use in applications"
  value = {
    cluster_name     = ionoscloud_k8s_cluster.main.name
    cluster_id       = ionoscloud_k8s_cluster.main.id
    datacenter_id    = ionoscloud_datacenter.main.id
    environment      = var.environment
    project_name     = var.project_name
  }
}

# FluxCD Information
output "flux_namespace" {
  description = "Namespace where FluxCD is installed"
  value       = kubernetes_namespace.flux_system.metadata[0].name
}

output "git_repository_url" {
  description = "Git repository URL used by FluxCD"
  value       = var.git_repository_url
  sensitive   = true
}