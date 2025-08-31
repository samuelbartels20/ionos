
# Datacenter
variable "datacenter_name" {
  description = "Name of the IONOS datacenter"
  type        = string
  validation {
    condition     = length(var.datacenter_name) > 0 && length(var.datacenter_name) <= 255
    error_message = "Datacenter name must be between 1 and 255 characters."
  }
}

variable "datacenter_location" {
  description = "Location of the IONOS datacenter"
  type        = string
  validation {
    condition = contains([
      "de/fra", "de/fra/2", "de/txl", "de/fkb",
      "gb/lhr", "gb/bhx", "fr/par", "es/vit",
      "us/ewr", "us/las", "us/mci"
    ], var.datacenter_location)
    error_message = "Invalid datacenter location. Must be a valid IONOS location."
  }
}

# Project
variable "project_name" {
  description = "Name of the IONOS project"
  type        = string
}

# IP Block
variable "ipblock_size" {
  description = "Size of the IONOS IP block"
  type        = number
  default     = 3
}


# Kubernetes Cluster
variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}
variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32.6"
}

variable "maintenance_day" {
  description = "Day of the week for maintenance window"
  type        = string
  default     = "Sunday"
}

variable "maintenance_time" {
  description = "Time for maintenance window (UTC)"
  type        = string
  default     = "02:00:00"
}

variable "api_subnet_allow_list" {
  description = "List of subnets allowed to access the Kubernetes API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
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
  validation {
    condition = contains([
      "AMD_OPTERON", "INTEL_XEON", "INTEL_SKYLAKE", 
      "INTEL_ICELAKE", "AMD_EPYC", "INTEL_SIERRA_FOREST"
    ], var.app_nodepool_cpu_family)
    error_message = "Invalid CPU family. Must be a supported IONOS CPU family."
  }
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

# 1password
variable "op_service_account_token" {
  type        = string
  description = "1Password service account token"
  sensitive   = true
}

variable "vault" {
  description = "Vault name to find the Item in"
  type        = string
  default     = "K8s"
}

variable "item" {
  description = "Password Item to fetch"
  type        = string
  default     = "ionos"
}

variable "aws_access_key_id" {
  description = "AWS access key ID"
  type        = string
  sensitive   = true
}
variable "aws_secret_access_key" {
  description = "AWS secret access key"
  type        = string
  sensitive   = true
}




