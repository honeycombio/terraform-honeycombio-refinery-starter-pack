####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "refinery-health" {
  calculation {
    op     = "SUM"
    column = "collect_cache_buffer_overrun"
  }

  calculation {
    op     = "MAX"
    column = "memory_inuse"
  }

  calculation {
    op     = "MAX"
    column = "collect_cache_entries_max"
  }

  calculation {
    op     = "MAX"
    column = "collect_cache_capacity"
  }

  calculation {
    op     = "MAX"
    column = "num_goroutines"
  }

  calculation {
    op     = "MAX"
    column = "process_uptime_seconds"
  }

  breakdowns = ["hostname"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-health-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-health.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-health-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-health-query.id
  name        = "Cache Health"
  description = "Overruns above 0 could mean needing to increase cache capacity. Memory at ~80% usage, the cache will be downsized to stop OOM's and thus could lead to overruns with a smaller capacity. cached_entries_max should give an idea about how many entries steady state in the cache."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-health-query-id" {
  value = honeycombio_query.refinery-health-query.id
}

output "refinery-health-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-health-query.id
}
