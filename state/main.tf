resource "aws_kms_key" "bucket_encryption" {
  description             = "This key is used to encrypt objects in S3 Buckets"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_key" "dynamodb_table_encryption" {
  description             = "This key is used to encrypt objects in DynamoDB tables"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

#tfsec:ignore:AWS002 - Disabled logging requirement as this is the logs bucket
resource "aws_s3_bucket" "terraform_state_logs" {
  bucket        = "slade-sandbox-terraform-state-logs"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.bucket_encryption.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name = "Slade-Testing"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_logs" {
  bucket = aws_s3_bucket.terraform_state_logs.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "slade-sandbox-terraform-state"
  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.terraform_state_logs.id
    target_prefix = "slade-terraform-state-logs"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.bucket_encryption.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    "Name" = "Slade-Testing"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_dynamodb_table" "terraform_state" {
  name         = "slade-sandbox-terraform-state"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.dynamodb_table_encryption.arn
  }

  tags = {
    "Name" = "Slade-Testing"
  }
}
