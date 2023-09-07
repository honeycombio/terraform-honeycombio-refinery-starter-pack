####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "dropped-from-stress" {
  calculation {
    op     = "SUM"
    column = "dropped_from_stress"
  }

  calculation {
    op     = "MAX"
    column = "dropped_from_stress"
  }

  breakdowns = ["hostname"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "dropped-from-stress-query" {
  count   = var.contains_stress_level ? 1 : 0
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.dropped-from-stress.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "dropped-from-stress-query" {
  count    = var.contains_stress_level ? 1 : 0
  dataset     = var.dataset_name
  query_id    = honeycombio_query.dropped-from-stress-query[0].id
  name        = "Dropped from Stress"
  description = "How many traces are being dropped due to stress on the Refinery cluster."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "dropped-from-stress-query-id" {
  value = var.contains_stress_level ? honeycombio_query.dropped-from-stress-query[0].id : null
}

output "dropped-from-stress-query-annotation-id" {
  value = var.contains_stress_level ? honeycombio_query_annotation.dropped-from-stress-query[0].id : null
}
