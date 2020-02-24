variable "region" {
  type = string
  default = "us-east-1"
}

variable "kinesis_analytics_app_name" {
  type = string
}

variable "name_prefix" {
  type = string
  description = "The Name Prefix to use when creating an in-application stream."
}

variable "parallelism_count" {
  type = string
  description = "The number of Parallel in-application streams to create."
  default = 1
}

variable "record_encoding" {
  type = string
  description = "The Encoding of the record in the streaming source."
  default = "UTF-8"
}

variable "kinesis_stream" {
  type = string
  description = "Name of the Kinesis stream to connect to."
  default = "data-stream-demo"
}

variable "record_columns" {
  type = list(map(string))
}