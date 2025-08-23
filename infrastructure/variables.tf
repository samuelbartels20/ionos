  # S3 Backend Configuration
variable "access_key" {
  description = "The access key for the S3 backend"
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "The secret key for the S3 backend"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ionos_username" {
  description = "The username for the IONOS Cloud"
  type        = string
  default     = ""
}

variable "ionos_password" {
  description = "The password for the IONOS Cloud"
  type        = string
  default     = ""
  sensitive   = true
}

variable "bucket_name" {
  description = "The bucket name for the S3 backend"
  type        = string
  default     = ""
}

variable "region" {
  description = "The region for the S3 backend"
  type        = string
  default     = "de/txl"
}

variable "endpoint" {
  description = "The endpoint for the S3 backend"
  type        = string
  default     = "https://s3-eu-central-1.ionoscloud.com"
}

variable "key" {
  description = "The key for the S3 backend"
  type        = string
  default     = "prod/terraform.tfstate"
}

# Infrastructure Configuration
variable "datacenter_name" {
  description = "Name of the IONOS datacenter"
  type        = string
  default     = "ionos-k8s-prod"
}

variable "datacenter_location" {
  description = "Location of the IONOS datacenter"
  type        = string
  default     = "de/txl"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "ionos-k8s-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28.5"
}

variable "maintenance_day" {
  description = "Day of the week for maintenance window"
  type        = string
  default     = "Sunday"
}

variable "maintenance_time" {
  description = "Time for maintenance window (UTC)"
  type        = string
  default     = "02:00:00Z"
}

variable "api_subnet_allow_list" {
  description = "List of subnets allowed to access the Kubernetes API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "s3_buckets" {
  description = "S3 buckets for cluster access"
  type        = list(string)
  default     = []
}

# System Node Pool Configuration
variable "system_nodepool_min_nodes" {
  description = "Minimum number of nodes in system node pool"
  type        = number
  default     = 1
}

variable "system_nodepool_max_nodes" {
  description = "Maximum number of nodes in system node pool"
  type        = number
  default     = 3
}

variable "system_nodepool_node_count" {
  description = "Initial number of nodes in system node pool"
  type        = number
  default     = 2
}

variable "system_nodepool_cpu_family" {
  description = "CPU family for system node pool"
  type        = string
  default     = "INTEL_SKYLAKE"
}

variable "system_nodepool_cores" {
  description = "Number of CPU cores for system nodes"
  type        = number
  default     = 2
}

variable "system_nodepool_ram" {
  description = "RAM size in MB for system nodes"
  type        = number
  default     = 4096
}

variable "system_nodepool_storage_size" {
  description = "Storage size in GB for system nodes"
  type        = number
  default     = 50
}

# Application Node Pool Configuration
variable "app_nodepool_min_nodes" {
  description = "Minimum number of nodes in application node pool"
  type        = number
  default     = 2
}

variable "app_nodepool_max_nodes" {
  description = "Maximum number of nodes in application node pool"
  type        = number
  default     = 10
}

variable "app_nodepool_node_count" {
  description = "Initial number of nodes in application node pool"
  type        = number
  default     = 3
}

variable "app_nodepool_cpu_family" {
  description = "CPU family for application node pool"
  type        = string
  default     = "INTEL_SKYLAKE"
}

variable "app_nodepool_cores" {
  description = "Number of CPU cores for application nodes"
  type        = number
  default     = 4
}

variable "app_nodepool_ram" {
  description = "RAM size in MB for application nodes"
  type        = number
  default     = 8192
}

variable "app_nodepool_storage_size" {
  description = "Storage size in GB for application nodes"
  type        = number
  default     = 100
}

# Monitoring Node Pool Configuration
variable "monitoring_nodepool_min_nodes" {
  description = "Minimum number of nodes in monitoring node pool"
  type        = number
  default     = 1
}

variable "monitoring_nodepool_max_nodes" {
  description = "Maximum number of nodes in monitoring node pool"
  type        = number
  default     = 3
}

variable "monitoring_nodepool_node_count" {
  description = "Initial number of nodes in monitoring node pool"
  type        = number
  default     = 2
}

variable "monitoring_nodepool_cpu_family" {
  description = "CPU family for monitoring node pool"
  type        = string
  default     = "INTEL_SKYLAKE"
}

variable "monitoring_nodepool_cores" {
  description = "Number of CPU cores for monitoring nodes"
  type        = number
  default     = 4
}

variable "monitoring_nodepool_ram" {
  description = "RAM size in MB for monitoring nodes"
  type        = number
  default     = 8192
}

variable "monitoring_nodepool_storage_size" {
  description = "Storage size in GB for monitoring nodes"
  type        = number
  default     = 100
}

# Git Configuration for FluxCD
variable "git_repository_url" {
  description = "Git repository URL for FluxCD"
  type        = string
  default     = "ssh://git@github.com/samuelbartels20/ionos.git"
}

variable "git_private_key" {
  description = "Private SSH key for Git repository access"
  type        = string
  default     = ""
  sensitive   = true
}

variable "git_public_key" {
  description = "Public SSH key for Git repository access"
  type        = string
  default     = ""
}

# Environment Configuration
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ionos-web-app"
}

# Tags
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "ionos-web-app"
    ManagedBy   = "terraform"
    Owner       = "platform-team"
  }
}

# PostgreSQL Database Configuration
variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "15"
}

variable "postgres_instances" {
  description = "Number of PostgreSQL instances"
  type        = number
  default     = 2
}

variable "postgres_cores" {
  description = "Number of cores for PostgreSQL"
  type        = number
  default     = 2
}

variable "postgres_ram" {
  description = "RAM size in GB for PostgreSQL"
  type        = number
  default     = 4
}

variable "postgres_storage_size" {
  description = "Storage size in GB for PostgreSQL"
  type        = number
  default     = 100
}

variable "postgres_username" {
  description = "PostgreSQL database username"
  type        = string
  default     = "wordpress"
}

# Redis Configuration
variable "redis_version" {
  description = "Redis version"
  type        = string
  default     = "7.0"
}

variable "redis_cores" {
  description = "Number of cores for Redis"
  type        = number
  default     = 1
}

variable "redis_ram" {
  description = "RAM size in GB for Redis"
  type        = number
  default     = 2
}

variable "redis_username" {
  description = "Redis username"
  type        = string
  default     = "redis"
}

# Backup Configuration
variable "backup_email" {
  description = "Email for backup notifications"
  type        = string
  default     = "admin@example.com"
}

variable "s3_region" {
  description = "S3 region for backup bucket"
  type        = string
  default     = "eu-central-3"
}