####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "stress-relief-status" {
  calculation {
    op     = "AVG"
    column = "stress_level"
  }

  calculation {
    op     = "MAX"
    column = "stress_relief_activated"
  }

  breakdowns = ["hostname"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "stress-relief-status-query" {
  count      = var.contains_stress_level ? 1 : 0
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.stress-relief-status.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "stress-relief-status-query" {
  count       = var.contains_stress_level ? 1 : 0
  dataset     = var.dataset_name
  query_id    = honeycombio_query.stress-relief-status-query[0].id
  name        = "Stress Relief Status"
  description = "Shows the `stress_level` metric (0-100) average as well as the `stress_relief_activated` metric (0 for not activated, 1 for activated) values grouped by hostname"
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "stress-relief-status-query-id" {
  value = var.contains_stress_level ? honeycombio_query.stress-relief-status-query[0].id : null
}

output "stress-relief-status-query-annotation-id" {
  value = var.contains_stress_level ? honeycombio_query_annotation.stress-relief-status-query[0].id : null
}
