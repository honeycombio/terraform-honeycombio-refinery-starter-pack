variable "refinery_metrics_dataset" {
  description = "Dataset to use for refinery metrics"
  type        = string
  default     = "Refinery Metrics"
}

variable "refinery_logs_dataset" {
  description = "Dataset to use for refinery logs"
  type        = string
  default     = "Refinery Logs"
}

variable "refinery_cluster_name" {
  description = "Name of the refinery cluster"
  type        = string
  default     = "Production"
}

variable "honeycomb_api_key" {
  description = "Honeycomb API key"
  type        = string
  default     = null
  # You can supply this via the environment variable HONEYCOMB_API_KEY or by setting the value in a .tfvars file
}
