provider "aws" {
  region     = "${var.region}"
}

resource "aws_kinesis_stream" "stream" {
  name             = "${var.stream_name}"
  shard_count      = "${var.shard_count}"
  retention_period = "${var.retention_period}"
  encryption_type = "${var.encryption_type}"
  kms_key_id = "${aws_kms_key.stream.id}"

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
    "OutgoingRecords",
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded",
    "IncomingRecords",
    "IteratorAgeMilliseconds",
  ]

  tags = {
    Environment = "${var.env}"
  }
}