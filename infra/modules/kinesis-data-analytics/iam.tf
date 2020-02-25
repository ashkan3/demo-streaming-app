resource "aws_iam_role" "kinesis_analytics_role" {
  name = "kinesis-analytics-role"
  assume_role_policy = file("${path.module}/roles/kinesis_analytics_role.json")

}

resource "aws_iam_role_policy" "kinesis_analytics_policy" {
  role = aws_iam_role.kinesis_analytics_role.id
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
      test = "StringLike"
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
      "${data.aws_lambda_function.pre_processing_lambda.arn}"
    ]
  }
}
