resource "ionoscloud_k8s_cluster" "k8s-cluster" {
  name                  = var.cluster_name
  k8s_version           = var.kubernetes_version
  maintenance_window {
    day_of_the_week     = var.maintenance_day
    time                = var.maintenance_time
  }
  api_subnet_allow_list = var.api_subnet_allow_list
  # s3_buckets { 
  #    name               = var.s3_bucket_name
  # }
  public = true
  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

# Application Node Pool (for application workloads)
resource "ionoscloud_k8s_node_pool" "application" {
  datacenter_id  = ionoscloud_datacenter.k8s-datacenter.id
  k8s_cluster_id = ionoscloud_k8s_cluster.k8s-cluster.id
  
  name        = "${var.cluster_name}-application"
  k8s_version = ionoscloud_k8s_cluster.k8s-cluster.k8s_version
  
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
    "cluster.ionos.com/managed-by"     = "terraform"
  }
  
  # public_ips = []  # Uncomment for private node pools
  
  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }
  
  depends_on = [ionoscloud_k8s_cluster.k8s-cluster]
}

resource "local_file" "kubeconfig" {
  # Use ionos CLI to get kubeconfig: ionosctl k8s kubeconfig get --cluster-id <cluster-id>
  content = "# Kubeconfig will be generated after cluster creation\n# Run: ionosctl k8s kubeconfig get --cluster-id ${ionoscloud_k8s_cluster.k8s-cluster.id} > kubeconfig\n"
  
  filename        = "${path.module}/kubeconfig"
  file_permission = "0600"
  
  depends_on = [ionoscloud_k8s_cluster.k8s-cluster]
}