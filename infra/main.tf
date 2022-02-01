resource "aws_kms_key" "s3_bucket_encryption" {
  description             = "This key is used to encrypt S3 buckets"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

#tfsec:ignore:AWS002 - Disabled logging requirement as not required for this setup.
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${local.prefix}-my-terraform-bucket"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.s3_bucket_encryption.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name = "${local.prefix} ${var.bucket_name}"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.my_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
