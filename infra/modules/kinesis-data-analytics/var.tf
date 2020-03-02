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

variable "destination_s3" {
  type        = string
  description = "Destinaiton S3 bucket for processed records coming from Kinesis Data Analytics app."
}

variable "destination_s3_buffer_size" {
  type        = string
  description = <<EOF
  "Buffer incoming data to the specified size, in MBs, before delivering it to the destination. The default value is 5.
We recommend setting SizeInMBs to a value greater than the amount of data you typically ingest into the delivery stream
in 10 seconds."
EOF
  default     = "5"
}

variable "destination_s3_buffer_interval" {
  type        = string
  description = "Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination."
  default     = "300"
}

variable "destination_s3_compression_format" {
  type        = string
  description = <<EOF
  "The compression format. If no value is specified, the default is UNCOMPRESSED. Other supported values are GZIP, ZIP
& Snappy. If the destination is redshift you cannot use ZIP or Snappy."
EOF
  default     = "UNCOMPRESSED"
}

variable "lambda_function_name" {
  type        = string
  description = "A unique name for the Lambda Function."
  default     = null
}

variable "lambda_filename" {
  type        = string
  description = "Name of Lambda source file."
  default     = null
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
  default     = null
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda function runtime, e.g. python3.7, java11."
  default     = null
}

variable "lambda_memory_size" {
  type        = string
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  default     = "128"
}

variable "lambda_concurrency" {
  type        = string
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
  default     = null
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

variable "lambda_publish" {
  type        = bool
  description = "Whether to publish creation/change as new Lambda Function Version. Defaults to true."
  default     = true
}

variable "lambda_event_age_in_seconds" {
  type        = number
  description = "Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600."
  default     = 100
}

variable "lambda_retry_attempts" {
  type        = number
  description = "Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2."
  default     = 0
}

variable "lambda_layer_name" {
  type        = string
  description = "A unique name for your Lambda Layer"
  default     = null
}

variable "lambda_layer_s3_bucket" {
  type        = string
  description = "The S3 bucket location containing the function's deployment package."
  default     = null
}

variable "lambda_layer_s3_key" {
  type        = string
  description = "The S3 key of an object containing the function's deployment package."
  default     = null
}

variable "lambda_layer_compatible_runtimes" {
  type        = list(string)
  description = "A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified."
  default     = null
}
