data "aws_kinesis_stream" "stream" {
  name = var.kinesis_stream
}