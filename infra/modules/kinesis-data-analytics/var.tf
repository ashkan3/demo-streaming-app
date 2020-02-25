variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to deploy the resources to."
}

variable "env" {
  type        = string
  description = "Environment in which resources are going to be deployed."
}

variable "kinesis_analytics_app_name" {
  type        = string
  description = "Name of kinesis data analytics application that will be created."
}

variable "name_prefix" {
  type        = string
  description = "The Name Prefix to use when creating an in-application stream."
}

variable "parallelism_count" {
  type        = string
  description = "The number of Parallel in-application streams to create."
  default     = 1
}

variable "record_encoding" {
  type        = string
  description = "The Encoding of the record in the streaming source."
  default     = "UTF-8"
}

variable "kinesis_stream" {
  type        = string
  description = "Name of the Kinesis stream to connect to."
}

variable "lambda_name" {
  type        = string
  description = "Name of the Lambda function that pre-processes records in the stream."
  default     = ""
}

variable "lambda_version" {
  type        = string
  description = "Version of Lambda function to call for pre-processing records."
  default     = ""
}

variable "sql_code" {
  type        = string
  description = "SQL Code to transform input data, and generate output."
  default     = ""
}

variable "record_columns" {
  type        = list(map(string))
  description = "The Record Column mapping for the streaming source data element."
}