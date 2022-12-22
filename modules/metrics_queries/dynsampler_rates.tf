####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "refinery-dynsampler-rates" {
  calculation {
    op     = "HEATMAP"
    column = "dynsampler_sample_rate_avg"
  }

  calculation {
    op     = "HEATMAP"
    column = "rulessampler_sample_rate_avg"
  }

  calculation {
    op     = "HEATMAP"
    column = "rulessampler_num_dropped"
  }

  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-dynsampler-rates-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-dynsampler-rates.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-dynsampler-rates-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-dynsampler-rates-query.id
  name        = "Sample Rates"
  description = "Sample rates from the dynamic and rules-based samplers."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-dynsampler-rates-query-id" {
  value = honeycombio_query.refinery-dynsampler-rates-query.id
}

output "refinery-dynsampler-rates-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-dynsampler-rates-query.id
}
