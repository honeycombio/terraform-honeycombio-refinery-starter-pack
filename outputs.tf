#####################
# Output Board URLs
#####################
output "refinery_operations_board_url" {
  value       = honeycombio_board.refinery.board_url
  description = "URL for accessing the \"Refinery Operations\" board in the Honeycomb UI"
}
