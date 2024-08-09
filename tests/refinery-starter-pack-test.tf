module "honeycombio-refinery-starter-pack" {
  source = "../"

  refinery_cluster_name    = "Test"
  create_datasets          = true
}

output "refinery_operations_board" {
  value       = module.honeycombio-refinery-starter-pack.refinery_operations_board_url
  description = "URL for accessing the \"Refinery Operations\" board in the Honeycomb UI"
}
