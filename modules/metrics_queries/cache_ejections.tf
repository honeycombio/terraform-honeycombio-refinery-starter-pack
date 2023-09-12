####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "cache-ejections" {
  calculation {
    op     = "MAX"
    column = "trace_send_ejected_full"
  }

  calculation {
    op     = "MAX"
    column = "trace_send_ejected_memsize"
  }

  breakdowns = ["hostname"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "cache-ejections-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.cache-ejections.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "cache-ejections-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.cache-ejections-query.id
  name        = "Cache Ejections"
  description = "`MAX(cache_send_ejected_full)` measures the number of traces ejected from the cache due to the cache being full.\n\n`MAX(cache_send_ejected_memsize)` measures the number of traces ejected from the cache due to there being not enough memory to cache more traces"
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "cache-ejections-query-id" {
  value = honeycombio_query.cache-ejections-query.id
}

output "cache-ejections-query-annotation-id" {
  value = honeycombio_query_annotation.cache-ejections-query.id
}
