resource "honeycombio_column" "dynsampler_sample_rate_avg" {
  key_name = "dynsampler_sample_rate_avg"
  type     = "float"
  dataset  = var.refinery_metrics_dataset
}

resource "honeycombio_column" "rulessampler_sample_rate_avg" {
  key_name = "rulessampler_sample_rate_avg"
  type     = "float"
  dataset  = var.refinery_metrics_dataset
}

resource "honeycombio_column" "rulessampler_num_dropped" {
  key_name = "rulessampler_num_dropped"
  type     = "float"
  dataset  = var.refinery_metrics_dataset
}

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

  time_range = 86400

  depends_on = [
    honeycombio_column.dynsampler_sample_rate_avg,
    honeycombio_column.rulessampler_sample_rate_avg,
    honeycombio_column.rulessampler_num_dropped,
  ]
}

resource "honeycombio_query" "refinery-dynsampler-rates-query" {
  dataset    = var.refinery_metrics_dataset
  query_json = data.honeycombio_query_specification.refinery-dynsampler-rates.json
}

resource "honeycombio_query_annotation" "refinery-dynsampler-rates-query" {
  dataset     = var.refinery_metrics_dataset
  query_id    = honeycombio_query.refinery-dynsampler-rates-query.id
  name        = "Sample Rates"
  description = "Sample rates from the dynamic and rules-based samplers."
}
