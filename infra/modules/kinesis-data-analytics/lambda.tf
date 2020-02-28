module lambda {
  source = "github.com/terraform-module/terraform-aws-lambda?ref=v2.9.0"

  function_name    = var.lambda_function_name
  filename         = data.archive_file.pre_processing_lambda.output_path
  source_code_hash = data.archive_file.pre_processing_lambda.output_sha
  description      = var.lambda_description
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  memory_size      = var.lambda_memory_size
  concurrency      = var.lambda_concurrency
  lambda_timeout   = var.lambda_timeout
  log_retention    = var.lambda_log_retention
  role_arn         = aws_iam_role.lambda_role.arn

  tags = {
    Environment = var.env
    App         = var.lambda_function_name
  }
}
