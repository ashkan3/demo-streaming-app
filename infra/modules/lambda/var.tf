variable "region" {
  type        = string
  description = "Region to deploy the resources to."
  default     = "us-east-1"
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
  description = "Name of Lambda zip file."
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
