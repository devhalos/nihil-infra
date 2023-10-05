resource "aws_dynamodb_table" "state_locking" {
  name         = "${local.component_name}-state-locking"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  tags         = var.tags

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }
}
