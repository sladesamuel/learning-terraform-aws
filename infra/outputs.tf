output "bucket_id" {
  description = "The Id of the S3 Bucket"
  value       = aws_s3_bucket.my_bucket.id
}
