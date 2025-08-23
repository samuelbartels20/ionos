# S3 Backend Configuration
access_key  = ""
secret_key  = ""
bucket_name = "ionos-backend"
region      = "de"
endpoint    = "https://s3-eu-central-1.ionoscloud.com"
key         = "prod/terraform.tfstate"

# Infrastructure Configuration
datacenter_name     = "ionos-k8s-prod"
datacenter_location = "de/fra"
cluster_name        = "ionos-k8s-cluster"
kubernetes_version  = "1.28.5"
environment         = "prod"
project_name        = "ionos-wp-app"

# Maintenance Window
maintenance_day  = "Sunday"
maintenance_time = "02:00:00Z"

# Security Configuration
api_subnet_allow_list = ["0.0.0.0/0"]

# Git Configuration for FluxCD
git_repository_url = "ssh://git@github.com/samuelbartels20/ionos.git"
# TODO: Add your SSH keys here after generating them
# git_private_key = "-----BEGIN OPENSSH PRIVATE KEY-----\n...\n-----END OPENSSH PRIVATE KEY-----"
# git_public_key = "ssh-rsa AAAAB3NzaC1yc2E..."

# Node Pool Configuration - System
system_nodepool_min_nodes    = 1
system_nodepool_max_nodes    = 3
system_nodepool_node_count   = 2
system_nodepool_cpu_family   = "INTEL_SKYLAKE"
system_nodepool_cores        = 2
system_nodepool_ram          = 4096
system_nodepool_storage_size = 50

# Node Pool Configuration - Application
app_nodepool_min_nodes    = 2
app_nodepool_max_nodes    = 10
app_nodepool_node_count   = 3
app_nodepool_cpu_family   = "INTEL_SKYLAKE"
app_nodepool_cores        = 4
app_nodepool_ram          = 8192
app_nodepool_storage_size = 100

# Node Pool Configuration - Monitoring
monitoring_nodepool_min_nodes    = 1
monitoring_nodepool_max_nodes    = 3
monitoring_nodepool_node_count   = 2
monitoring_nodepool_cpu_family   = "INTEL_SKYLAKE"
monitoring_nodepool_cores        = 4
monitoring_nodepool_ram          = 8192
monitoring_nodepool_storage_size = 100

# MariaDB Database Configuration
mariadb_version      = "11.0"
mariadb_instances    = 2
mariadb_cores        = 2
mariadb_ram          = 4
mariadb_storage_size = 100
mariadb_username     = "wordpress"

# Redis Configuration
redis_version = "7.0"
redis_cores   = 4
redis_ram     = 8
redis_username = "redis"

# Backup Configuration
backup_email = "bartelssamuel20@gmail.com"
s3_region    = "de/fra"

# Common Tags
common_tags = {
  Environment = "prod"
  Project     = "ionos-wp-app"
  ManagedBy   = "terraform"
  Owner       = "platform-team"
  CostCenter  = "engineering"
}