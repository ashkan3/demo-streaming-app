resource "aws_kms_key" "stream" {
  description             = "KMS key used for ${var.stream_name} stream."
  deletion_window_in_days = 10

  tags = {
    Environment = var.env
    App         = var.stream_name
  }
}