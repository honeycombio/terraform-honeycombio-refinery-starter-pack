#############################################################
# Define Required Columns in the Metrics and Logs Datasets
#############################################################
locals {
  metrics_columns_r1 = [
    "collect_cache_buffer_overrun",
    "collect_cache_capacity",
    "collect_cache_entries_max",
    "dropped_from_stress",
    "hostname",
    "incoming_router_dropped",
    "incoming_router_span",
    "libhoney_peer_queue_overflow",
    "libhoney_peer_send_errors",
    "libhoney_upstream_enqueue_errors",
    "libhoney_upstream_queue_length",
    "libhoney_upstream_response_errors",
    "libhoney_upstream_send_errors",
    "libhoney_upstream_send_retries",
    "num_goroutines",
    "memory_inuse",
    "process_uptime_seconds",
    "peer_router_batch",
    "peer_router_dropped",
    "trace_accepted",
    "trace_send_dropped",
    "trace_send_ejected_full",
    "trace_send_ejected_memsize",
    "trace_send_kept",
    "trace_send_no_root",
    "trace_sent_cache_hit",
  ]

  sampler_r1_metrics_columns = [
    "dynsampler_sample_rate_avg",
    "rulessampler_sample_rate_avg",
    "rulessampler_num_dropped",
  ]

  stress_level_columns = [
    "stress_level",
    "stress_relief_activated",
  ]

  metrics_columns_r2 = [
    "collect_cache_buffer_overrun",
    "collect_cache_capacity",
    "collect_cache_entries_max",
    "dropped_from_stress",
    "hostname",
    "incoming_router_dropped",
    "incoming_router_span",
    "libhoney_peer_queue_overflow",
    "libhoney_peer_send_errors",
    "libhoney_upstream_enqueue_errors",
    "libhoney_upstream_queue_length",
    "libhoney_upstream_response_errors",
    "libhoney_upstream_send_errors",
    "libhoney_upstream_send_retries",
    "num_goroutines",
    "memory_inuse",
    "process_uptime_seconds",
    "peer_router_batch",
    "peer_router_dropped",
    "trace_accepted",
    "trace_send_dropped",
    "trace_send_ejected_full",
    "trace_send_ejected_memsize",
    "trace_send_kept",
    "trace_send_no_root",
    "trace_sent_cache_hit",
  ]

  sampler_r2_metrics_columns = [
    "deterministic_num_kept",
    "deterministic_num_dropped",
    "dynamic_sample_rate_avg",
    "emadynamic_sample_rate_avg",
    "emathroughput_sample_rate_avg",
    "rulesbased_sample_rate_avg",
    "totalthroughput_sample_rate_avg",
    "windowedthroughput_sample_rate_avg",
  ]

  otel_metrics_columns = [
    "collect_cache_buffer_overrun",
    "collect_cache_capacity",
    "collect_cache_entries.max",
    "dropped_from_stress",
    "hostname",
    "incoming_router_dropped",
    "incoming_router_span",
    "libhoney_peer_queue_overflow",
    "libhoney_peer_send_errors",
    "libhoney_upstream_enqueue_errors",
    "libhoney_upstream_queue_length",
    "libhoney_upstream_response_errors",
    "libhoney_upstream_send_errors",
    "libhoney_upstream_send_retries",
    "num_goroutines",
    "memory_inuse",
    "process_uptime_seconds",
    "peer_router_batch",
    "peer_router_dropped",
    "trace_accepted",
    "trace_send_dropped",
    "trace_send_ejected_full",
    "trace_send_ejected_memsize",
    "trace_send_kept",
    "trace_send_no_root",
    "trace_sent_cache_hit",
  ]

  sampler_otel_metrics_columns = [
    "deterministic_num_kept",
    "deterministic_num_dropped",
    "dynamic_sample_rate.avg",
    "emadynamic_sample_rate.avg",
    "emathroughput_sample_rate.avg",
    "rulesbased_sample_rate.avg",
    "totalthroughput_sample_rate.avg",
    "windowedthroughput_sample_rate.avg",
  ]

  logs_columns = [
    "error",
    "error.err",
    "error.msg",
    "msg",
  ]

  contains_r2_metrics   = contains(data.honeycombio_columns.metrics.names, "rulesbased_sample_rate_avg") ? true : contains(data.honeycombio_columns.metrics.names, "rulesbased_sample_rate.avg")
  contains_otel_metrics = contains(data.honeycombio_columns.metrics.names, "host.name")
}
