# Datacenter
output "datacenter_name" {
  description = "The name of the datacenter"
  value       = ionoscloud_datacenter.k8s-datacenter.name
}
output "datacenter_location" {
  description = "The location of the datacenter"
  value       = ionoscloud_datacenter.k8s-datacenter.location
}
output "datacenter_id" {
  description = "The ID of the datacenter"
  value       = ionoscloud_datacenter.k8s-datacenter.id
}

# IP Block
output "ipblock_name" {
  description = "The name of the IP block"
  value       = ionoscloud_ipblock.k8s-ipblock.name
}
output "ipblock_id" {
  description = "The ID of the IP block"
  value       = ionoscloud_ipblock.k8s-ipblock.id
}
# LAN
output "public_lan_name" {
  description = "The name of the public LAN"
  value       = ionoscloud_lan.k8s-public-lan.name
}
output "public_lan_id" {
  description = "The ID of the public LAN"
  value       = ionoscloud_lan.k8s-public-lan.id
}
output "private_lan_name" {
  description = "The name of the private LAN"
  value       = ionoscloud_lan.k8s-private-lan.name
}
output "private_lan_id" {
  description = "The ID of the private LAN"
  value       = ionoscloud_lan.k8s-private-lan.id
}

# Kubernetes Cluster
output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = ionoscloud_k8s_cluster.k8s-cluster.name
}
output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = ionoscloud_k8s_cluster.k8s-cluster.id
}

# Application Node Pool
output "app_nodepool_name" {
  description = "The name of the application node pool"
  value       = ionoscloud_k8s_node_pool.application.name
}
output "app_nodepool_id" {
  description = "The ID of the application node pool"
  value       = ionoscloud_k8s_node_pool.application.id
}

# Get kubeconfig
output "kubeconfig" {
  description = "The kubeconfig for the Kubernetes cluster"
  value       = local_file.kubeconfig.content
}
output "kubeconfig_path" {
  description = "The path to the kubeconfig file"
  value       = local_file.kubeconfig.filename
}

output "ionos_endpoint" {
  sensitive   = true
  description = "The endpoint of the IONOS API"
  value       = data.onepassword_item.ionos.IONOS_ENDPOINT
}
output "ionos_username" {
  sensitive   = true
  description = "The username of the IONOS API"
  value       = data.onepassword_item.ionos.IONOS_USERNAME
}
output "ionos_password" {
  sensitive   = true
  description = "The password of the IONOS API"
  value       = data.onepassword_item.ionos.IONOS_PASSWORD
}

output "ionos_token" {
  sensitive   = true
  description = "The token of the IONOS API"
  value       = data.onepassword_item.ionos.IONOS_TOKEN
}


