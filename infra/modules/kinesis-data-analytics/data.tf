data "aws_kinesis_stream" "stream" {
  name = var.kinesis_stream
}

data "aws_lambda_function" "pre_processing_lambda" {
  function_name = var.lambda_name
}

data "terraform_remote_state" "kinesis_stream" {
  backend = "s3"
  config = {
    bucket = "demo-app-terraform-state-files"
    key    = "stream/terraform.tfstate"
    region = var.region
  }
}
