####################################################
# Create Dataset to Contain all Required Columns
####################################################
resource "honeycombio_dataset" "refinery-logs-dataset" {
  count       = var.create_datasets ? 1 : 0
  name        = var.refinery_logs_dataset
  description = "Dataset for Refinery logs"
}

resource "honeycombio_dataset" "refinery-metrics-dataset" {
  count       = var.create_datasets ? 1 : 0
  name        = var.refinery_metrics_dataset
  description = "Dataset for Refinery metrics"
}

####################################################
# Create Columns in the Metrics Dataset
####################################################
module "metrics_columns" {
  source       = "./modules/columns"
  count        = var.create_columns ? 1 : 0
  dataset_name = var.refinery_metrics_dataset
  columns = {
    "dynsampler_sample_rate_avg"     = "float",
    "rulessampler_sample_rate_avg"   = "float",
    "rulessampler_num_dropped"       = "float",
    "incoming_router_span"           = "float",
    "peer_router_batch"              = "float",
    "hostname"                       = "string",
    "collect_cache_buffer_overrun"   = "float",
    "memory_inuse"                   = "float",
    "collect_cache_entries_max"      = "float",
    "collect_cache_capacity"         = "float",
    "num_goroutines"                 = "float",
    "process_uptime_seconds"         = "float",
    "incoming_router_dropped"        = "float",
    "peer_router_dropped"            = "float",
    "trace_accepted"                 = "float",
    "trace_send_dropped"             = "float",
    "trace_send_kept"                = "float",
    "libhoney_peer_queue_overflow"   = "float",
    "libhoney_peer_send_errors"      = "float",
    "libhoney_upstream_queue_length" = "float",
    "upstream_enqueue_errors"        = "float",
    "upstream_response_errors"       = "float",
    "trace_sent_cache_hit"           = "float",
    "trace_send_no_root"             = "float",
  }

  depends_on = [
    honeycombio_dataset.refinery-metrics-dataset
  ]
}

####################################################
# Create Queries Against Metrics Dataset
####################################################
module "metrics_queries" {
  source       = "./modules/metrics_queries"
  dataset_name = var.refinery_metrics_dataset

  depends_on = [
    honeycombio_dataset.refinery-metrics-dataset,
    module.metrics_columns
  ]
}

####################################################
# Create Refinery Board
####################################################
resource "honeycombio_board" "refinery" {
  name  = "${var.refinery_cluster_name} Refinery Operations"
  style = "visual"
  query {
    query_id            = module.metrics_queries.refinery-health-query-id
    query_annotation_id = module.metrics_queries.refinery-health-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.refinery-intercommunication-query-id
    query_annotation_id = module.metrics_queries.refinery-intercommunication-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.refinery-receive-buffers-query-id
    query_annotation_id = module.metrics_queries.refinery-receive-buffers-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.refinery-send-buffers-query-id
    query_annotation_id = module.metrics_queries.refinery-send-buffers-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.refinery-dynsampler-rates-query-id
    query_annotation_id = module.metrics_queries.refinery-dynsampler-rates-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.refinery-trace-indicators-query-id
    query_annotation_id = module.metrics_queries.refinery-trace-indicators-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.refinery-sampling-decision-query-id
    query_annotation_id = module.metrics_queries.refinery-sampling-decision-query-annotation-id
  }

  depends_on = [
    honeycombio_dataset.refinery-metrics-dataset,
    module.metrics_columns,
    module.metrics_queries,
  ]
}
