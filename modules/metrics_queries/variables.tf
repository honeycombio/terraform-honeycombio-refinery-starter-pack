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

variable "contains_stress_level" {
  type = bool
}

variable "sampler_columns" {
  type = list(string)
}

variable "contains_otel_metrics" {
  type = bool
}
