data "honeycombio_query_specification" "refinery-trace-indicators" {
  calculation {
    op     = "SUM"
    column = "trace_sent_cache_hit"
  }

  calculation {
    op     = "SUM"
    column = "trace_send_no_root"
  }

  time_range = 86400
}

resource "honeycombio_query" "refinery-trace-indicators-query" {
  dataset    = var.refinery_metrics_dataset
  query_json = data.honeycombio_query_specification.refinery-trace-indicators.json
}

resource "honeycombio_query_annotation" "refinery-trace-indicators-query" {
  dataset     = var.refinery_metrics_dataset
  query_id    = honeycombio_query.refinery-trace-indicators-query.id
  name        = "Trace Indicators"
  description = "Cache hits means a span belonging to a trace that had already been sent. No Roots are traces are being sent before they are completed so Check out overruns or if a node shutdown recently if you see a lot of no roots."
}
