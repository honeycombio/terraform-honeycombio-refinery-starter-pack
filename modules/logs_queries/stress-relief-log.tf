####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "stress-relief-log" {
  calculation {
    op = "COUNT"
  }
  filter {
    column    = "msg"
    op  = "contains"
    value = "StressRelief"
  }
  breakdowns = ["hostname", "reason", "msg"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "stress-relief-log-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.stress-relief-log.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "stress-relief-log-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.stress-relief-log-query.id
  name        = "Stress Relief Log"
  description = "The raw data tab here will have the reason refinery is going into stress relief."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "stress-relief-log-query-id" {
  value = honeycombio_query.stress-relief-log-query.id
}

output "stress-relief-log-query-annotation-id" {
  value = honeycombio_query_annotation.stress-relief-log-query.id
}
