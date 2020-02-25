module lambda {
  source = "github.com/terraform-module/terraform-aws-lambda?ref=v2.9.0"

  function_name  = var.function_name
  filename       = "${path.cwd}/${var.filename}"
  description    = var.description
  handler        = var.handler
  runtime        = var.runtime
  memory_size    = var.memory_size
  concurrency    = var.concurrency
  lambda_timeout = var.timeout
  log_retention  = var.log_retention
  role_arn       = aws_iam_role.lambda_role.arn

  tags = {
    Environment = var.env
    App         = var.function_name
  }
}
