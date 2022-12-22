variable "dataset_name" {
  description = "The name of the dataset where columns will need to be created"
  type        = string
}

variable "columns" {
  type        = map(string)
  description = "The list of columns being created as a map object with the key being the column name and value being the column type"
}
