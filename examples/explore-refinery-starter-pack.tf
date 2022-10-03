module "honeycombio-refinery-starter-pack" {
  source = "honeycombio/refinery-starter-pack/honeycombio"

  refinery_metrics_dataset = "Refinery Metrics" # Optional: defaults to "Refinery Metrics"
  refinery_logs_dataset = "Refinery Logs" # Optional: defaults to "Refinery Metrics"
  refinery_cluster_name = "Production" # Optional: defaults to "Production"
}
