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

variable "create_datasets" {
  description = "Have the module create the datasets if they don't exist"
  type        = bool
  default     = false
}

variable "create_columns" {
  description = "Have the module create columns in the dataset if they don't exist"
  type        = bool
  default     = false
}

variable "time_range" {
  description = "The default time range for queries in the Refinery metrics board - Defaults to 86400 seconds (24hours)"
  type        = number
  default     = 86400
}
