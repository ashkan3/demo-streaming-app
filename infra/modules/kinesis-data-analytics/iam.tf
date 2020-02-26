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

  statement {
    actions = [
      "firehose:DescribeDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]
    resources = [
      "arn:aws:firehose:us-east-1:206612368495:deliverystream/${aws_kinesis_firehose_delivery_stream.extended_s3_stream.name}"
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

resource "aws_iam_role" "kinesis_firehose_role" {
  name               = "kinesis-firehose-role"
  assume_role_policy = file("${path.module}/roles/kinesis_firehose_role.json")

}

resource "aws_iam_role_policy" "kinesis_firehose_policy" {
  role   = aws_iam_role.kinesis_firehose_role.id
  policy = data.aws_iam_policy_document.kinesis_firehose_policy_doc.json
}

data "aws_iam_policy_document" "kinesis_firehose_policy_doc" {

  statement {
    sid = "ReadAndWriteToS3"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.destination_bucket.id}",
      "arn:aws:s3:::${aws_s3_bucket.destination_bucket.id}/*",
    ]
  }

  statement {
    sid = "CreateCloudWatchLogStream"
    actions = [
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:us-east-1:206612368495:log-group:/aws/kinesisfirehose/${aws_kinesis_firehose_delivery_stream.extended_s3_stream.name}:log-stream:*"
    ]
  }
}