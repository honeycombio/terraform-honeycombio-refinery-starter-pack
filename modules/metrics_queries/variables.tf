variable "dataset_name" {
  description = "Dataset to attach queries to"
  type        = string
  default     = "Refinery Metrics"
}

variable "time_range" {
  description = "The default time range for queries in the Refinery metrics board - Defaults to 86400 seconds (24hours)"
  type        = number
  default     = 86400
}
