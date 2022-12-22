module "honeycombio-refinery-starter-pack" {
  source = "honeycombio/refinery-starter-pack/honeycombio"

  refinery_metrics_dataset = "Refinery Metrics" # Optional: defaults to "Refinery Metrics"
  refinery_logs_dataset    = "Refinery Logs"    # Optional: defaults to "Refinery Metrics"
  refinery_cluster_name    = "Production"       # Optional: defaults to "Production"
  create_datasets          = false              # Optional: defaults to false
  create_columns           = false              # Optional: defaults to false
  time_range               = 86400              # Optional: defaults to 86400 (24 hours)
}

output "refinery_operations_board" {
  value       = module.honeycombio-refinery-starter-pack.refinery_operations_board_url
  description = "URL for accessing the \"Refinery Operations\" board in the Honeycomb UI"
}
