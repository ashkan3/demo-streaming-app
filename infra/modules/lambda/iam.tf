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
    sid       = "AllowCreateLogGroup"
    actions   = ["logs:CreateLogGroup"]
    resources = ["*"]
  }

  statement {
    sid = "AllowLoggingToCloudWatch"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    sid = "ReadEncryptedInputKinesisStream"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      var.key_arn
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

}
