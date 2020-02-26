resource "aws_s3_bucket" "destination_bucket" {
  bucket = "tf-test-bucket-test-test"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "destination_bucket" {
  bucket = "${aws_s3_bucket.destination_bucket.id}"

  block_public_acls   = true
  block_public_policy = true
}
