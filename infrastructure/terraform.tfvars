
datacenter_name     = "k8s-datacenter"
datacenter_location = "de/fra"

ipblock_size        = 3

app_nodepool_min_nodes    = 3
app_nodepool_max_nodes    = 5
app_nodepool_node_count   = 3
app_nodepool_cpu_family   = "INTEL_SKYLAKE"
app_nodepool_cores        = 4
app_nodepool_ram          = 4096
app_nodepool_storage_size = 100

cluster_name          = "ionos-k8s-production"
kubernetes_version    = "1.32.6"
maintenance_day       = "Sunday"
maintenance_time      = "10:00:00"
api_subnet_allow_list = ["0.0.0.0/0"]

region = "us-east-1"

