resource "aws_s3_bucket" "terraform-state" {
    bucket = "terraform-state"

    varsioning {
        enabled = true
    }

    # Enable server-side encryption by default
    server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              sse_algorithm = "AES256"
          }
      }
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LOCKID"

    attribute {
      name = "LOCKID"
      type = "S"
    }
}
