data "aws_kinesis_stream" "stream" {
  name = var.kinesis_stream
}

data "terraform_remote_state" "kinesis_stream" {
  backend = "s3"
  config = {
    bucket = "demo-app-terraform-state-files"
    key    = "apps/streams/${var.kinesis_stream}/terraform.tfstate"
    region = var.region
  }
}

data "aws_s3_bucket" "destination_bucket" {
  bucket = var.destination_s3
}