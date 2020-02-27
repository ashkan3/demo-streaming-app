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
  default     = "SOURCE_SQL_STREAM"
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
}

variable "record_columns" {
  type        = list(map(string))
  description = "The Record Column mapping for the streaming source data element."
}

variable "output_stream_name" {
  type        = string
  description = "The Name of the in-application stream."
  default     = "DESTINATION_SQL_STREAM"
}

variable "output_record_format_type" {
  type        = string
  description = "The Format Type of the records on the output stream. Can be CSV or JSON."
  default     = "JSON"
}

variable "lambda_function_name" {
  type        = string
  description = "A unique name for the Lambda Function."
}

variable "lambda_filename" {
  type        = string
  description = "Name of Lambda zip file."
  default     = "lambda.zip"
}

variable "lambda_version" {
  type        = string
  description = "Version of Lambda function to call for pre-processing records."
  default     = "$LATEST"
}

variable "lambda_description" {
  type        = string
  description = "Description of what the Lambda Function does."
  default     = "Pre-processing Lambda function."
}

variable "lambda_handler" {
  type        = string
  description = "The function entrypoint in Lambda code."
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda function runtime, e.g. python3.7, java11."
}

variable "lambda_memory_size" {
  type        = string
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  default     = "128"
}

variable "lambda_concurrency" {
  type        = string
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."

}

variable "lambda_timeout" {
  type        = string
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = "5"
}

variable "lambda_log_retention" {
  type        = string
  description = "Specifies the number of days you want to retain log events in the specified log group."
  default     = "1"
}
