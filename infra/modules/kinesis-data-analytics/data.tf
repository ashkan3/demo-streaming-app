data "aws_kinesis_stream" "stream" {
  name = var.kinesis_stream
}

data "terraform_remote_state" "kinesis_stream" {
  backend = "s3"
  config = {
    bucket = "demo-app-terraform-state-files"
    key    = "${var.env}/apps/streams/${var.kinesis_stream}/terraform.tfstate"
    region = var.region
  }
}

data "aws_s3_bucket" "destination_bucket" {
  bucket = var.destination_s3
}

data "archive_file" "pre_processing_lambda" {
  count       = var.lambda_filename != null ? 1 : 0
  source_file = "${path.cwd}/${var.lambda_filename}"
  output_path = "lambda.zip"
  type        = "zip"
}
