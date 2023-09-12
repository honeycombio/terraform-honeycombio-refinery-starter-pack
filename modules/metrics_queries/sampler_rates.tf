####################################################
# Define the Query Specification
####################################################
data "honeycombio_query_specification" "refinery-sampler-rates" {

  dynamic "calculation" {
    for_each = var.sampler_columns
    content {
      op     = "HEATMAP"
      column = calculation.value
    }
  }

  time_range = var.time_range
}

####################################################
# Implement the Query Using the Specification
####################################################
resource "honeycombio_query" "refinery-sampler-rates-query" {
  dataset    = var.dataset_name
  query_json = data.honeycombio_query_specification.refinery-sampler-rates.json
}

################################################################
# Attach an Annotation to the Query to Explain What it Does
################################################################
resource "honeycombio_query_annotation" "refinery-sampler-rates-query" {
  dataset     = var.dataset_name
  query_id    = honeycombio_query.refinery-sampler-rates-query.id
  name        = "Sample Rates"
  description = "Sample rates from the samplers used by the Refinery cluster."
}

####################################################
# Create Outputs for Use by Other Modules
####################################################
output "refinery-sampler-rates-query-id" {
  value = honeycombio_query.refinery-sampler-rates-query.id
}

output "refinery-sampler-rates-query-annotation-id" {
  value = honeycombio_query_annotation.refinery-sampler-rates-query.id
}
