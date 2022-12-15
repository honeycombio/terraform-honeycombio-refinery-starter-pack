resource "honeycombio_column" "collect_cache_buffer_overrun" {
  key_name = "collect_cache_buffer_overrun"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "memory_inuse" {
  key_name = "memory_inuse"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "collect_cache_entries_max" {
  key_name = "collect_cache_entries_max"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "collect_cache_capacity" {
  key_name = "collect_cache_capacity"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "num_goroutines" {
  key_name = "num_goroutines"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "process_uptime_seconds" {
  key_name = "process_uptime_seconds"
  type = "float"
  dataset = var.refinery_metrics_dataset
}

resource "honeycombio_column" "hostname" {
  key_name = "hostname"
  type = "float"
  dataset = var.refinery_metrics_dataset
}


data "honeycombio_query_specification" "refinery-health" {
  calculation {
    op     = "SUM"
    column = "collect_cache_buffer_overrun"
  }

  calculation {
    op     = "MAX"
    column = "memory_inuse"
  }

  calculation {
    op     = "MAX"
    column = "collect_cache_entries_max"
  }

  calculation {
    op     = "MAX"
    column = "collect_cache_capacity"
  }

  calculation {
    op     = "MAX"
    column = "num_goroutines"
  }

  calculation {
    op     = "MAX"
    column = "process_uptime_seconds"
  }

  breakdowns = ["hostname"]
  time_range = 86400

  depends_on = [
    honeycombio_column.collect_cache_buffer_overrun,
    honeycombio_column.memory_inuse,
    honeycombio_column.collect_cache_entries_max,
    honeycombio_column.collect_cache_capacity,
    honeycombio_column.num_goroutines,
    honeycombio_column.process_uptime_seconds,
    honeycombio_column.hostname,
  ]
}

resource "honeycombio_query" "refinery-health-query" {
  dataset    = var.refinery_metrics_dataset
  query_json = data.honeycombio_query_specification.refinery-health.json
}

resource "honeycombio_query_annotation" "refinery-health-query" {
  dataset     = var.refinery_metrics_dataset
  query_id    = honeycombio_query.refinery-health-query.id
  name        = "Cache Health"
  description = "Overruns above 0 could mean needing to increase cache capacity. Memory at ~80% usage, the cache will be downsized to stop OOM's and thus could lead to overruns with a smaller capacity. cached_entries_max should give an idea about how many entries steady state in the cache."
}
