variable "metrics_dataset" {
  type = string
}

variable "logs_dataset" {
  type = string
}

variable "metrics_columns" {
  type = list(string)
}

variable "logs_columns" {
  type = list(string)
}
