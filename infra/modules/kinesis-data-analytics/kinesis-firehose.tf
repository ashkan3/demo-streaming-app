resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  name        = var.kinesis_analytics_app_name
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn            = aws_iam_role.kinesis_firehose_role.arn
    bucket_arn          = data.aws_s3_bucket.destination_bucket.arn
    prefix              = "${var.kinesis_stream}/"
    error_output_prefix = "${var.kinesis_stream}-failed-records/"
    buffer_size         = var.destination_s3_buffer_size
    buffer_interval     = var.destination_s3_buffer_interval
    compression_format  = var.destination_s3_compression_format
    kms_key_arn         = data.terraform_remote_state.kinesis_stream.outputs.key_arn
  }
}
