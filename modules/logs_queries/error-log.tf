####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "error-log" {
  calculation {
    op = "COUNT"
  }

  filter {
    column   = "error"
    op = "exists"
  }

  filter {
    column   = "error.err"
    op = "exists"
  }

  filter {
    column   = "error.msg"
    op = "exists"
  }

  filter_combination = "OR"

  breakdowns = ["hostname", "error", "error.err", "error.msg"]
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "error-log-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.error-log.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "error-log-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.error-log-query.id
  name        = "Refinery Error Log"
  description = "When errors are occuring with processing data or sending it to Honeycomb, they will show up here."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "error-log-query-id" {
  value = honeycombio_query.error-log-query.id
}

output "error-log-query-annotation-id" {
  value = honeycombio_query_annotation.error-log-query.id
}
