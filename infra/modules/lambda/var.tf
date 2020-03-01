variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to deploy the resources to."
}

variable "env" {
  type        = string
  description = "Environment in which resources are going to be deployed."
}

variable "function_name" {
  type        = string
  description = "A unique name for the Lambda Function."
}

variable "filename" {
  type        = string
  description = "Name of Lambda source file."
}

variable "description" {
  type        = string
  description = "Description of what the Lambda Function does."
  default     = "Pre-processing Lambda function."
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

variable "timeout" {
  type        = string
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = "5"
}

variable "log_retention" {
  type        = string
  description = "Specifies the number of days you want to retain log events in the specified log group."
  default     = "1"
}

variable "iam_policy_path" {
  type        = string
  description = "Relative path to the IAM policy template file."
}

variable "kinesis_streams" {
  type        = list(string)
  description = "List of Kinesis streams that producer Lambda function needs to have access to."
  default     = []
}

variable "layer_name" {
  type        = string
  description = "Name of Lambda layer."
  default     = null
}

variable "layer_s3_bucket" {
  type        = string
  description = "Name of S3 bucket where Lambda layer is stored."
  default     = null
}

variable "layer_s3_key" {
  type        = string
  description = "Name of the Layer zip file stored in s3."
  default     = null
}

variable "layer_compatible_runtimes" {
  type        = list(string)
  description = "Compatible runtimes with this Lambda layer."
  default     = null
}
