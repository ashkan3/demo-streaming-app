output "key_arn" {
  value = aws_kms_key.stream.arn
}

output "stream_arn" {
  value = aws_kinesis_stream.stream.arn
}
