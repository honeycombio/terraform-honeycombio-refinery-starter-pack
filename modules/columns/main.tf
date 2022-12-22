resource "honeycombio_column" "columns" {
  count   = length(var.columns)
  name    = keys(var.columns)[count.index]
  type    = values(var.columns)[count.index]
  dataset = var.dataset_name
}
