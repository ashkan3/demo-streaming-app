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

variable "sql_code" {
  type        = string
  description = "SQL Code to transform input data, and generate output."
  default     = ""
}

variable "record_columns" {
  type        = list(map(string))
  description = "The Record Column mapping for the streaming source data element."
}

variable "function_name" {
  type        = string
  description = "A unique name for the Lambda Function."
}

variable "filename" {
  type        = string
  description = "Name of Lambda zip file."
}

variable "lambda_version" {
  type        = string
  description = "Version of Lambda function to call for pre-processing records."
}

variable "description" {
  type        = string
  description = "Description of what the Lambda Function does."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in Lambda code."
}

variable "runtime" {
  type        = string
  description = "Lambda function runtime, e.g. python3.7, java11."
}

variable "memory_size" {
  type        = string
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  default     = "128"
}

variable "concurrency" {
  type        = string
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."

}

variable "lambda_timeout" {
  type        = string
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = "5"
}

variable "log_retention" {
  type        = string
  description = "Specifies the number of days you want to retain log events in the specified log group."
  default     = "1"
}
