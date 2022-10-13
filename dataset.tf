//if this dataset already exists, creating this resource is a no-op.
resource "honeycombio_dataset" "refinery_metrics" {
  name        = "Refinery Metrics"
  description = "Refinery metrics"
}
