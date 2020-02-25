data "aws_kinesis_stream" "stream" {
  name = var.kinesis_stream
}

data "aws_lambda_function" "pre_processing_lambda" {
  function_name = var.lambda_name
}
