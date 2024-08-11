resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  force_destroy = true

  tags = {
    Name        = "DevOps"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms" # The default aws/s3 AWS KMS master key is used for encryption
    }
  }
}
