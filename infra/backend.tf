terraform {
  backend "s3" {
    bucket         = "slade-sandbox-terraform-state"
    key            = "slade-test"
    region         = "eu-west-2"
    dynamodb_table = "slade-sandbox-terraform-state"
  }
}
