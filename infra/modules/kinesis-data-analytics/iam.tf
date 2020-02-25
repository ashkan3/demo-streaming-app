resource "aws_iam_role" "kinesis_analytics_role" {
  name               = "kinesis-analytics-role"
  assume_role_policy = file("${path.module}/roles/kinesis_analytics_role.json")

}

resource "aws_iam_role_policy" "kinesis_analytics_policy" {
  role   = aws_iam_role.kinesis_analytics_role.id
  policy = data.aws_iam_policy_document.kinesis_analytics_policy_doc.json
}

data "aws_iam_policy_document" "kinesis_analytics_policy_doc" {
  statement {
    sid = "ReadInputKinesis"

    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords"
    ]

    resources = [
      "arn:aws:kinesis:us-east-1:206612368495:stream/${var.kinesis_stream}",
    ]
  }

  statement {
    sid = "ReadEncryptedInputKinesisStream"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      data.terraform_remote_state.kinesis_stream.outputs.key_arn
    ]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"

      values = [
        "kinesis.us-east-1.amazonaws.com"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:kinesis:arn"
      values = [
        "arn:aws:kinesis:us-east-1:206612368495:stream/${var.kinesis_stream}"
      ]
    }
  }

  statement {
    sid = "UseLambdaFunction"
    actions = [
      "lambda:InvokeFunction",
      "lambda:GetFunctionConfiguration"
    ]

    resources = [
      # TODO specify resources to limit access
      "*"
    ]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "pre-processing-lambda-role"
  assume_role_policy = file("${path.module}/roles/lambda_role.json")
}

resource "aws_iam_role_policy" "lambda_policy" {
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_policy_document.json
}

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    sid     = "AllowCreateLogGroup"
    actions = ["logs:CreateLogGroup"]
    resources = [
      # TODO specify resources to limit access
      "*"
    ]
  }

  statement {
    sid = "AllowLoggingToCloudWatch"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      # TODO specify resources to limit access
      "*"
    ]
  }
}
