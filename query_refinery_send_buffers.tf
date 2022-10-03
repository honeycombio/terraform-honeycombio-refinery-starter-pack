resource "honeycombio_column" "libhoney_peer_queue_overflow" {
  key_name    = "libhoney_peer_queue_overflow"
  type        = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "libhoney_peer_send_errors" {
  key_name    = "libhoney_peer_send_errors"
  type        = "float"
  dataset = var.refinery_metrics_dataset
}


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
  time_range = 86400

  depends_on = [
    honeycombio_column.libhoney_peer_queue_overflow,
    honeycombio_column.libhoney_peer_send_errors,
  ]
}

resource "honeycombio_query" "refinery-send-buffers-query" {
  dataset    = var.refinery_metrics_dataset
  query_json = data.honeycombio_query_specification.refinery-send-buffers.json
}

resource "honeycombio_query_annotation" "refinery-send-buffers-query" {
  dataset     = var.refinery_metrics_dataset
  query_id    = honeycombio_query.refinery-send-buffers-query.id
  name        = "Send Buffers"
  description = "Monitor libhoney_peer_queue_overflow. If it is consistently above 0, increase PeerBufferSize. Monitor libhoney_upstream_queue_length and look for values to stay under the UpstreamBufferSize value. If it hits UpstreamBufferSize, refinery will block waiting to send upstream to API"
}
