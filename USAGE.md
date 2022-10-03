<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_honeycombio"></a> [honeycombio](#requirement\_honeycombio) | ~> 0.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_honeycombio"></a> [honeycombio](#provider\_honeycombio) | ~> 0.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [honeycombio_board.refinery](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/board) | resource |
| [honeycombio_column.dynsampler_sample_rate_avg](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/column) | resource |
| [honeycombio_column.libhoney_peer_queue_overflow](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/column) | resource |
| [honeycombio_column.libhoney_peer_send_errors](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/column) | resource |
| [honeycombio_column.rulessampler_num_dropped](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/column) | resource |
| [honeycombio_column.rulessampler_sample_rate_avg](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/column) | resource |
| [honeycombio_query.refinery-dynsampler-rates-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query) | resource |
| [honeycombio_query.refinery-health-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query) | resource |
| [honeycombio_query.refinery-intercommunication-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query) | resource |
| [honeycombio_query.refinery-receive-buffers-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query) | resource |
| [honeycombio_query.refinery-sampling-decision-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query) | resource |
| [honeycombio_query.refinery-send-buffers-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query) | resource |
| [honeycombio_query.refinery-trace-indicators-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query) | resource |
| [honeycombio_query_annotation.refinery-dynsampler-rates-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query_annotation) | resource |
| [honeycombio_query_annotation.refinery-health-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query_annotation) | resource |
| [honeycombio_query_annotation.refinery-intercommunication-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query_annotation) | resource |
| [honeycombio_query_annotation.refinery-receive-buffers-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query_annotation) | resource |
| [honeycombio_query_annotation.refinery-sampling-decision-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query_annotation) | resource |
| [honeycombio_query_annotation.refinery-send-buffers-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query_annotation) | resource |
| [honeycombio_query_annotation.refinery-trace-indicators-query](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query_annotation) | resource |
| [honeycombio_query_specification.refinery-dynsampler-rates](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/data-sources/query_specification) | data source |
| [honeycombio_query_specification.refinery-health](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/data-sources/query_specification) | data source |
| [honeycombio_query_specification.refinery-intercommunication](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/data-sources/query_specification) | data source |
| [honeycombio_query_specification.refinery-receive-buffers](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/data-sources/query_specification) | data source |
| [honeycombio_query_specification.refinery-sampling-decision](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/data-sources/query_specification) | data source |
| [honeycombio_query_specification.refinery-send-buffers](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/data-sources/query_specification) | data source |
| [honeycombio_query_specification.refinery-trace-indicators](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/data-sources/query_specification) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_honeycomb_api_key"></a> [honeycomb\_api\_key](#input\_honeycomb\_api\_key) | Honeycomb API key | `string` | `null` | no |
| <a name="input_refinery_cluster_name"></a> [refinery\_cluster\_name](#input\_refinery\_cluster\_name) | Name of the refinery cluster | `string` | `"Production"` | no |
| <a name="input_refinery_logs_dataset"></a> [refinery\_logs\_dataset](#input\_refinery\_logs\_dataset) | Dataset to use for refinery logs | `string` | `"Refinery Logs"` | no |
| <a name="input_refinery_metrics_dataset"></a> [refinery\_metrics\_dataset](#input\_refinery\_metrics\_dataset) | Dataset to use for refinery metrics | `string` | `"Refinery Metrics"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->