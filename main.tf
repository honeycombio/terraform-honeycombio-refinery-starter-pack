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
# Create Columns For Queries
####################################################
data "honeycombio_columns" "metrics" {
  dataset = var.refinery_metrics_dataset
}

data "honeycombio_columns" "logs" {
  dataset = var.refinery_logs_dataset
}

module "columns" {
  source = "./modules/columns"

  metrics_dataset = var.refinery_metrics_dataset
  logs_dataset    = var.refinery_logs_dataset

  metrics_columns = local.contains_r2_metrics ? local.contains_otel_metrics ? flatten(setsubtract(local.otel_metrics_columns, data.honeycombio_columns.metrics.names)) : flatten(setsubtract(local.metrics_columns_r2, data.honeycombio_columns.metrics.names)) : flatten(setsubtract(local.metrics_columns_r1, data.honeycombio_columns.metrics.names))
  logs_columns    = flatten(setsubtract(local.logs_columns, data.honeycombio_columns.logs.names))
}

####################################################
# Create Queries Against Metrics Dataset
####################################################
module "metrics_queries" {
  source       = "./modules/metrics_queries"
  dataset_name = var.refinery_metrics_dataset

  contains_stress_level = contains(data.honeycombio_columns.metrics.names, "stress_level")
  contains_otel_metrics = local.contains_otel_metrics
  sampler_columns       = local.contains_r2_metrics ? local.contains_otel_metrics ? setintersection(local.sampler_otel_metrics_columns, data.honeycombio_columns.metrics.names) : setintersection(local.sampler_r2_metrics_columns, data.honeycombio_columns.metrics.names) : setintersection(local.sampler_r1_metrics_columns, data.honeycombio_columns.metrics.names)

  depends_on = [
    honeycombio_dataset.refinery-metrics-dataset,
    module.columns,
  ]
}

####################################################
# Create Queries Against Logs Dataset
####################################################
module "logs_queries" {
  source       = "./modules/logs_queries"
  dataset_name = var.refinery_logs_dataset

  depends_on = [
    honeycombio_dataset.refinery-logs-dataset,
    module.columns,
  ]
}

####################################################
# Create Refinery Board
####################################################
resource "honeycombio_board" "refinery" {
  name  = "${var.refinery_cluster_name} Refinery Operations"
  style = "visual"

  dynamic "query" {
    for_each = contains(data.honeycombio_columns.metrics.names, "stress_level") ? ["srs", "dfs"] : []

    content {
      query_id            = query.value == "srs" ? module.metrics_queries.stress-relief-status-query-id : module.metrics_queries.dropped-from-stress-query-id
      query_annotation_id = query.value == "srs" ? module.metrics_queries.stress-relief-status-query-annotation-id : module.metrics_queries.dropped-from-stress-query-annotation-id
    }
  }

  dynamic "query" {
    for_each = contains(data.honeycombio_columns.metrics.names, "stress_level") ? ["stress-relief-log"] : []

    content {
      query_id            = module.logs_queries.stress-relief-log-query-id
      query_annotation_id = module.logs_queries.stress-relief-log-query-annotation-id
      query_style         = "table"
    }
  }

  query {
    query_id            = module.metrics_queries.cache-health-query-id
    query_annotation_id = module.metrics_queries.cache-health-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.cache-ejections-query-id
    query_annotation_id = module.metrics_queries.cache-ejections-query-annotation-id
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
    query_id            = module.logs_queries.error-log-query-id
    query_annotation_id = module.logs_queries.error-log-query-annotation-id
  }

  query {
    query_id            = module.metrics_queries.refinery-sampler-rates-query-id
    query_annotation_id = module.metrics_queries.refinery-sampler-rates-query-annotation-id
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
    honeycombio_dataset.refinery-logs-dataset,
    module.columns,
    module.metrics_queries,
    module.logs_queries,
  ]
}
