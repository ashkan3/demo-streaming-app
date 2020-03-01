resource "aws_iam_role" "lambda_role" {
  name               = "${var.function_name}-lambda-role"
  assume_role_policy = file("${path.module}/roles/lambda_role.json")
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.id
  policy = templatefile("${path.cwd}/${var.iam_policy_path}", {
    region        = var.region,
    account_id    = data.aws_caller_identity.current.account_id,
    function_name = var.function_name,
    key_arns      = local.key_arns,
    kinesis_arns  = local.kinesis_arns
  })
}



