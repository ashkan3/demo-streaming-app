provider "aws" {
  region     = var.region
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
          mapping = record_columns.value["mapping"]
          name = record_columns.value["name"]
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

    processing_configuration {
      lambda {
        resource_arn = data.aws_lambda_function.pre_processing_lambda.arn
        role_arn = aws_iam_role.kinesis_analytics_role.arn
      }
    }
  }

  tags = {
    Environment = var.env
    App         = var.kinesis_analytics_app_name
  }
}