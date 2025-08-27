
variable "ionos_endpoint" {
  description = "The endpoint for the IONOS Cloud"
  type        = string
  default     = "api.ionos.com"
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.ionos_endpoint))
    error_message = "The IONOS endpoint must be a valid domain name."
  }
}