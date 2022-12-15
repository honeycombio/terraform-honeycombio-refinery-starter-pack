####################################################
# Create Dataset to Contain all Required Columns
####################################################
resource "honeycombio_dataset" "refinery-logs-dataset" {
  name        = var.refinery_logs_dataset
  description = "Dataset for Refinery logs"
}

resource "honeycombio_dataset" "refinery-metrics-dataset" {
  name        = var.refinery_metrics_dataset
  description = "Dataset for Refinery metrics"
}
