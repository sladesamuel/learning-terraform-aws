resource "aws_s3_bucket" "terraform_state" {
  bucket        = "slade-sandbox-terraform-state"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags = {
    "Name" = "Slade-Testing"
  }
}

resource "aws_dynamodb_table" "terraform_state" {
  name         = "slade-sandbox-terraform-state"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name" = "Slade-Testing"
  }
}
