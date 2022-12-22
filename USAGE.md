<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_honeycombio"></a> [honeycombio](#requirement\_honeycombio) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_honeycombio"></a> [honeycombio](#provider\_honeycombio) | >= 0.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metrics_columns"></a> [metrics\_columns](#module\_metrics\_columns) | ./modules/columns | n/a |
| <a name="module_metrics_queries"></a> [metrics\_queries](#module\_metrics\_queries) | ./modules/metrics_queries | n/a |

## Resources

| Name | Type |
|------|------|
| [honeycombio_board.refinery](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/board) | resource |
| [honeycombio_dataset.refinery-logs-dataset](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/dataset) | resource |
| [honeycombio_dataset.refinery-metrics-dataset](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/dataset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_columns"></a> [create\_columns](#input\_create\_columns) | Have the module create columns in the dataset if they don't exist | `bool` | `false` | no |
| <a name="input_create_datasets"></a> [create\_datasets](#input\_create\_datasets) | Have the module create the datasets if they don't exist | `bool` | `false` | no |
| <a name="input_refinery_cluster_name"></a> [refinery\_cluster\_name](#input\_refinery\_cluster\_name) | Name of the refinery cluster | `string` | `"Production"` | no |
| <a name="input_refinery_logs_dataset"></a> [refinery\_logs\_dataset](#input\_refinery\_logs\_dataset) | Dataset to use for refinery logs | `string` | `"Refinery Logs"` | no |
| <a name="input_refinery_metrics_dataset"></a> [refinery\_metrics\_dataset](#input\_refinery\_metrics\_dataset) | Dataset to use for refinery metrics | `string` | `"Refinery Metrics"` | no |
| <a name="input_time_range"></a> [time\_range](#input\_time\_range) | The default time range for queries in the Refinery metrics board - Defaults to 86400 seconds (24hours) | `number` | `86400` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_refinery_operations_board_url"></a> [refinery\_operations\_board\_url](#output\_refinery\_operations\_board\_url) | URL for accessing the "Refinery Operations" board in the Honeycomb UI |
<!-- END_TF_DOCS -->