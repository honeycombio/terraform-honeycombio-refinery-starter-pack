####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "refinery-send-buffers" {
  calculation {
    op     = "SUM"
    column = "libhoney_peer_queue_overflow"
  }

  calculation {
    op     = "SUM"
    column = "libhoney_peer_send_errors"
  }

  calculation {
    op     = "MAX"
    column = "libhoney_upstream_queue_length"
  }

  calculation {
    op     = "SUM"
    column = "upstream_enqueue_errors"
  }

  calculation {
    op     = "SUM"
    column = "upstream_response_errors"
  }

  breakdowns = ["hostname"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-send-buffers-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-send-buffers.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-send-buffers-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-send-buffers-query.id
  name        = "Send Buffers"
  description = "Monitor libhoney_peer_queue_overflow. If it is consistently above 0, increase PeerBufferSize. Monitor libhoney_upstream_queue_length and look for values to stay under the UpstreamBufferSize value. If it hits UpstreamBufferSize, refinery will block waiting to send upstream to API"
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-send-buffers-query-id" {
  value = honeycombio_query.refinery-send-buffers-query.id
}

output "refinery-send-buffers-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-send-buffers-query.id
}
