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
            "Action" = [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
            "Resource" = [
                "arn:aws:logs:${region}:${account_id}:log-group:/aws/lambda/${function_name}:*"
            ]
        },
        {
            "Effect" = "Allow"
            "Action" = [
                "lambda:*",
                "lambda:GetFunctionConfiguration"
            ]
            "Resource": [
                "*"
            ]
        }
    ]
})}
