resource "aws_s3_bucket" "b" {
  bucket = "tfstate-lock"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Terraform State File Storage"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "tfstate-lock-table"
  hash_key = "LockID"
  read_capacity = 2
  write_capacity = 2

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
