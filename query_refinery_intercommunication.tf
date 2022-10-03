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
  time_range = 86400
}

resource "honeycombio_query" "refinery-intercommunication-query" {
  dataset    = var.refinery_metrics_dataset
  query_json = data.honeycombio_query_specification.refinery-intercommunication.json
}

resource "honeycombio_query_annotation" "refinery-intercommunication-query" {
  dataset     = var.refinery_metrics_dataset
  query_id    = honeycombio_query.refinery-intercommunication-query.id
  name        = "Intercommunications"
  description = "Incoming are events from outside the cluster in. Peer is communication between nodes."
}
