resource "aws_iam_role" "role" {
  name = "kinesis_analytics_role"
  assume_role_policy = "${file("${path.module}/role.json")}"

}

resource "aws_iam_role_policy" "policy" {
  role = "${aws_iam_role.role.id}"
  policy = "${data.aws_iam_policy_document.kinesis_analytics_policy.json}"
}

data "aws_iam_policy_document" "kinesis_analytics_policy" {
  statement {
    sid = "ReadInputKinesis"

    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords"
    ]

    resources = [
      "arn:aws:kinesis:us-east-1:206612368495:stream/${kinesis_stream}",
    ]
  }

  statement {
    sid = "ReadEncryptedInputKinesisStream"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "${var.key_arn}"
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
        "arn:aws:kinesis:us-east-1:206612368495:stream/${kinesis_stream}"]
    }
  }

  statement {
    sid = "UseLambdaFunction"
    actions = [
      "lambda:InvokeFunction",
      "lambda:GetFunctionConfiguration"
    ]

    resources = [
      "${var.lambda_arn}:${var.lambda_version}"
    ]
  }
}
