####################################################
# Define the Query Specification
####################################################
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
  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-sampling-decision-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-sampling-decision.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-sampling-decision-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-sampling-decision-query.id
  name        = "Sampling Decisions"
  description = "How many traces are coming in and sent/dropped."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-sampling-decision-query-id" {
  value = honeycombio_query.refinery-sampling-decision-query.id
}

output "refinery-sampling-decision-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-sampling-decision-query.id
}
