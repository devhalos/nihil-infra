output "state_bucket_name" {
  value = aws_s3_bucket.state.bucket
}

output "state_lock_table_name" {
  value = aws_dynamodb_table.state_locking.name
}
