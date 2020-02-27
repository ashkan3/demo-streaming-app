provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "destination_bucket" {
  bucket = "coveo-events-stream"
  acl    = "private"
  # TODO
  # 1. apply a life cyle policy to this bucket
}

resource "aws_s3_bucket_public_access_block" "destination_bucket" {
  bucket = aws_s3_bucket.destination_bucket.id

  block_public_acls   = true
  block_public_policy = true
}
