provider "aws" {
  region = var.region
}

locals {
  lambda = aws_lambda_function.pre_processing_lambda.*
}

resource "aws_kinesis_analytics_application" "application" {
  name = var.kinesis_analytics_app_name
  code = var.sql_code

  inputs {
    name_prefix = var.name_prefix

    kinesis_stream {
      resource_arn = data.aws_kinesis_stream.stream.arn
      role_arn     = aws_iam_role.kinesis_analytics_role.arn
    }

    parallelism {
      count = var.parallelism_count
    }

    schema {
      dynamic "record_columns" {
        for_each = var.record_columns
        content {
          mapping  = record_columns.value["mapping"]
          name     = record_columns.value["name"]
          sql_type = record_columns.value["sql_type"]
        }

      }

      record_encoding = var.record_encoding

      record_format {
        mapping_parameters {
          json {
            record_row_path = "$"
          }
        }
      }
    }

    dynamic "processing_configuration" {
      for_each = local.lambda
      content {
        dynamic "lambda" {
          for_each = local.lambda
          content {
            resource_arn = lambda.value["arn"]
            role_arn     = aws_iam_role.kinesis_analytics_role.arn
          }
        }
      }
    }
  }

  outputs {
    name = var.output_stream_name
    schema {
      record_format_type = var.output_record_format_type
    }

    kinesis_firehose {
      resource_arn = aws_kinesis_firehose_delivery_stream.extended_s3_stream.arn
      role_arn     = aws_iam_role.kinesis_analytics_role.arn
    }
  }

  tags = {
    Environment = var.env
    App         = var.kinesis_analytics_app_name
  }

  depends_on = [
    aws_lambda_function.pre_processing_lambda
  ]
}