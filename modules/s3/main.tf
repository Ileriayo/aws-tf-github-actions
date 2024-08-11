resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  force_destroy = true

  tags = {
    Name        = "DevOps"
    Environment = "Dev"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable server side encryption, using Amazon managed keys.
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms" # The default aws/s3 AWS KMS master key is used for encryption
    }
  }
}

# Enforce ownership, Disable ACLs
resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Configure an access point in the default VPC
data "aws_vpc" "default" {
  default = true
} 
resource "aws_s3_access_point" "access_point" {
  bucket = aws_s3_bucket.bucket.id
  name   = "ileriaccesspoint"

  # VPC must be specified for S3 on Outposts
  vpc_configuration {
    vpc_id = data.aws_vpc.default.id
  }
}
