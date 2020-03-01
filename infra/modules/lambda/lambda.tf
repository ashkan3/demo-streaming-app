provider "aws" {
  region = var.region
}

module lambda {
  source = "github.com/ashkan3/terraform-aws-lambda"

  function_name             = var.function_name
  filename                  = data.archive_file.lambda.output_path
  source_code_hash          = data.archive_file.lambda.output_sha
  description               = var.description
  handler                   = var.handler
  runtime                   = var.runtime
  memory_size               = var.memory_size
  concurrency               = var.concurrency
  lambda_timeout            = var.timeout
  log_retention             = var.log_retention
  role_arn                  = aws_iam_role.lambda_role.arn
  layer_name                = var.layer_name
  layer_s3_bucket           = var.layer_s3_bucket
  layer_s3_key              = var.layer_s3_key
  layer_compatible_runtimes = var.layer_compatible_runtimes


  tags = {
    Environment = var.env
    App         = var.function_name
  }
}
