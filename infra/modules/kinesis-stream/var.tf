variable "region" {
  type = string
  description = "Region to deploy the resources to."
  default = "us-east-1"
}

variable "env" {
  type = string
  description = "Environment in which resources are going to be deployed."
}

variable "stream_name" {
  type = string
  description = "A name to identify the stream. This is unique to the AWS account and region the Stream is created in."
}

variable "shard_count" {
  type = string
  description = "The number of shards that the stream will use. Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream."
  default = "1"
}

variable "retention_period" {
  type = string
  description = "Length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 168 hours. Minimum value is 24. Default is 24."
  default = "24"
}

variable "encryption_type" {
  type = string
  description = "The encryption type to use. The only acceptable values are NONE or KMS. The default value is NONE."
}