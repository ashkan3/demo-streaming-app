data "aws_caller_identity" "current" {}

locals {
  key_arns     = data.terraform_remote_state.kinesis_stream.*.outputs.key_arn
  kinesis_arns = data.terraform_remote_state.kinesis_stream.*.outputs.stream_arn
}

data "archive_file" "lambda" {
  source_file = "${path.cwd}/${var.filename}"
  output_path = "lambda.zip"
  type        = "zip"
}

data "terraform_remote_state" "kinesis_stream" {
  count   = length(var.kinesis_streams)
  backend = "s3"
  config = {
    bucket = "demo-app-terraform-state-files"
    key    = "apps/streams/${var.kinesis_streams[count.index]}/terraform.tfstate"
    region = var.region
  }
}
