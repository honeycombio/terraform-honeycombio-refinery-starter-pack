resource "honeycombio_column" "trace_accepted" {
  key_name = "trace_accepted"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "trace_send_dropped" {
  key_name = "trace_send_dropped"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "trace_send_kept" {
  key_name = "trace_send_kept"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

data "honeycombio_query_specification" "refinery-sampling-decision" {
  calculation {
    op     = "MAX"
    column = "trace_accepted"
  }

  calculation {
    op     = "MAX"
    column = "trace_send_dropped"
  }

  calculation {
    op     = "MAX"
    column = "trace_send_kept"
  }

  order {
    column = "trace_accepted"
    op     = "MAX"
    order  = "descending"
  }

  breakdowns = ["hostname"]
  time_range = 86400

  depends_on = [
    honeycombio_column.trace_accepted,
    honeycombio_column.trace_send_dropped,
    honeycombio_column.trace_send_kept,
    honeycombio_column.hostname,
  ]
}

resource "honeycombio_query" "refinery-sampling-decision-query" {
  dataset    = var.refinery_metrics_dataset
  query_json = data.honeycombio_query_specification.refinery-sampling-decision.json
}

resource "honeycombio_query_annotation" "refinery-sampling-decision-query" {
  dataset     = var.refinery_metrics_dataset
  query_id    = honeycombio_query.refinery-sampling-decision-query.id
  name        = "Sampling Decisions"
  description = "How many traces are coming in and sent/dropped."
}
