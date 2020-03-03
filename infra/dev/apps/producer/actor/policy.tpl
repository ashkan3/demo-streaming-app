${jsonencode({
    "Version" = "2012-10-17"
    Statement = [
        {
            "Effect" = "Allow"
            "Action" = "logs:CreateLogGroup"
            "Resource" = "arn:aws:logs:${region}:${account_id}:*"
        },
        {
            "Effect" = "Allow"
            "Action" =  [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
            "Resource" = "arn:aws:logs:${region}:${account_id}:log-group:/aws/lambda/${function_name}:*"
        },
        {
            "Effect" = "Allow"
            "Action" = "s3:GetObject"
            "Resource" = "arn:aws:s3:::${events_bucket}/*"
        },
        {
            "Effect" = "Allow",
            "Action" = [
                "kinesis:PutRecords",
                "kinesis:DescribeStream"
            ]
            "Resource" = [
                for kinesis_arn in kinesis_arns:
                    "${kinesis_arn}"
            ]
        },
        {
            "Effect" = "Allow"
            "Action" = "kms:GenerateDataKey"
            "Resource" = [
                for key_arn in key_arns:
                    "${key_arn}"
             ]
        },
    ]
})}
