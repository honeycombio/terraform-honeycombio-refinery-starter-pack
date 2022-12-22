####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "refinery-receive-buffers" {
  calculation {
    op     = "SUM"
    column = "incoming_router_dropped"
  }

  calculation {
    op     = "SUM"
    column = "peer_router_dropped"
  }

  breakdowns = ["hostname"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-receive-buffers-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-receive-buffers.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-receive-buffers-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-receive-buffers-query.id
  name        = "Receive Buffers"
  description = "Look for values above 0. If either metric is consistently above 0, increase CacheCapacity. The receive buffers are consistently three times the size of CacheCapacity."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-receive-buffers-query-id" {
  value = honeycombio_query.refinery-receive-buffers-query.id
}

output "refinery-receive-buffers-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-receive-buffers-query.id
}
