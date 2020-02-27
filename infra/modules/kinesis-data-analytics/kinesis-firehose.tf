resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  name        = "kinesis-firehose-${var.kinesis_stream}"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.kinesis_firehose_role.arn
    bucket_arn = data.aws_s3_bucket.destination_bucket.arn
  }
}
