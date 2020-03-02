resource aws_lambda_function pre_processing_lambda {
  count                          = var.lambda_filename != null ? 1 : 0
  function_name                  = var.lambda_function_name
  filename                       = data.archive_file.pre_processing_lambda[0].output_path
  description                    = var.lambda_description
  role                           = aws_iam_role.lambda_role[0].arn
  handler                        = var.lambda_handler
  runtime                        = var.lambda_runtime
  memory_size                    = var.lambda_memory_size
  publish                        = var.lambda_publish
  reserved_concurrent_executions = var.lambda_concurrency
  timeout                        = var.lambda_timeout
  source_code_hash               = data.archive_file.pre_processing_lambda[0].output_sha
  layers                         = var.lambda_layer_name != null ? ["${aws_lambda_layer_version.lambda_layer[0].arn}"] : null

  lifecycle {
    ignore_changes = [
      filename,
    ]
  }

  tags = {
    App         = var.kinesis_analytics_app_name,
    Function    = var.lambda_function_name,
    Environment = var.env
  }

  depends_on = [aws_cloudwatch_log_group.this]
}

resource aws_lambda_layer_version lambda_layer {
  count               = var.lambda_layer_name != null ? 1 : 0
  layer_name          = var.lambda_layer_name
  s3_bucket           = var.lambda_layer_s3_bucket
  s3_key              = var.lambda_layer_s3_key
  compatible_runtimes = var.lambda_layer_compatible_runtimes
}

resource aws_lambda_function_event_invoke_config customized_config {
  count                        = var.lambda_filename != null ? 1 : 0
  function_name                = aws_lambda_function.pre_processing_lambda[0].function_name
  qualifier                    = aws_lambda_function.pre_processing_lambda[0].version
  maximum_event_age_in_seconds = var.lambda_event_age_in_seconds
  maximum_retry_attempts       = var.lambda_retry_attempts
}

resource aws_lambda_function_event_invoke_config latest {
  count                        = var.lambda_filename != null ? 1 : 0
  function_name                = aws_lambda_function.pre_processing_lambda[0].function_name
  qualifier                    = "$LATEST"
  maximum_event_age_in_seconds = var.lambda_event_age_in_seconds
  maximum_retry_attempts       = var.lambda_retry_attempts
}

resource aws_cloudwatch_log_group this {
  count             = var.lambda_filename != null ? 1 : 0
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.lambda_log_retention

  tags = {
    App         = var.kinesis_analytics_app_name,
    Function    = var.lambda_function_name,
    Environment = var.env
  }
}
