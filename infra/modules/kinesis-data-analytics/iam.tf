resource "aws_iam_role" "role" {

  name = "test_role"
  assume_role_policy = "${file("${path.module}/role.json")}"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "policy" {
  role = "${aws_iam_role.role.id}"
  policy = "${file("${path.module}/policy.json")}"
}