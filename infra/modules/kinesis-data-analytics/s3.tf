resource "aws_s3_bucket" "destination_bucket" {
  bucket = "tf-test-bucket-test-test"
  acl    = "private"
  # TODO
  # 1. apply a life cyle policy to this bucket
  # 2. extract creation of this bucket from this module
  #    so that can be shared between multiple consumers
}

resource "aws_s3_bucket_public_access_block" "destination_bucket" {
  bucket = aws_s3_bucket.destination_bucket.id

  block_public_acls   = true
  block_public_policy = true
}
