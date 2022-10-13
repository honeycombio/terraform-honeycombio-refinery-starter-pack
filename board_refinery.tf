# Board definition
resource "honeycombio_board" "refinery" {
  name  = "${var.refinery_cluster_name} Refinery Operations"
  style = "visual"
  query {
    dataset             = var.refinery_metrics_dataset
    query_id            = honeycombio_query.refinery-health-query.id
    query_annotation_id = honeycombio_query_annotation.refinery-health-query.id
  }

  query {
    dataset             = var.refinery_metrics_dataset
    query_id            = honeycombio_query.refinery-intercommunication-query.id
    query_annotation_id = honeycombio_query_annotation.refinery-intercommunication-query.id
  }

  query {
    dataset             = var.refinery_metrics_dataset
    query_id            = honeycombio_query.refinery-receive-buffers-query.id
    query_annotation_id = honeycombio_query_annotation.refinery-receive-buffers-query.id
  }

  query {
    dataset             = var.refinery_metrics_dataset
    query_id            = honeycombio_query.refinery-send-buffers-query.id
    query_annotation_id = honeycombio_query_annotation.refinery-send-buffers-query.id
  }

  query {
    dataset             = var.refinery_metrics_dataset
    query_id            = honeycombio_query.refinery-dynsampler-rates-query.id
    query_annotation_id = honeycombio_query_annotation.refinery-dynsampler-rates-query.id
  }

  query {
    dataset             = var.refinery_metrics_dataset
    query_id            = honeycombio_query.refinery-trace-indicators-query.id
    query_annotation_id = honeycombio_query_annotation.refinery-trace-indicators-query.id
  }

  query {
    dataset             = var.refinery_metrics_dataset
    query_id            = honeycombio_query.refinery-sampling-decision-query.id
    query_annotation_id = honeycombio_query_annotation.refinery-sampling-decision-query.id
  }

  depends_on = [
    honeycombio_dataset.refinery_metrics
  ]
}
