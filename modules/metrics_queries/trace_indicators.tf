####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "refinery-trace-indicators" {
  calculation {
    op     = "SUM"
    column = "trace_sent_cache_hit"
  }

  calculation {
    op     = "SUM"
    column = "trace_send_no_root"
  }

  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-trace-indicators-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-trace-indicators.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-trace-indicators-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-trace-indicators-query.id
  name        = "Trace Indicators"
  description = "Cache hits means a span belonging to a trace that had already been sent. No Roots are traces are being sent before they are completed so Check out overruns or if a node shutdown recently if you see a lot of no roots."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-trace-indicators-query-id" {
  value = honeycombio_query.refinery-trace-indicators-query.id
}

output "refinery-trace-indicators-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-trace-indicators-query.id
}
