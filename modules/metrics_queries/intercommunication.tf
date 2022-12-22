####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "refinery-intercommunication" {
  calculation {
    op     = "SUM"
    column = "incoming_router_span"
  }

  calculation {
    op     = "SUM"
    column = "peer_router_batch"
  }

  order {
    column = "incoming_router_span"
    op     = "SUM"
    order  = "descending"
  }

  breakdowns = ["hostname"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-intercommunication-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-intercommunication.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-intercommunication-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-intercommunication-query.id
  name        = "Intercommunications"
  description = "Incoming are events from outside the cluster in. Peer is communication between nodes."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-intercommunication-query-id" {
  value = honeycombio_query.refinery-intercommunication-query.id
}

output "refinery-intercommunication-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-intercommunication-query.id
}
