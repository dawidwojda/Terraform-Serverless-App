resource "aws_dynamodb_table" "table" {
    name = var.dynamodb_name
    hash_key = var.dynamodb_hash_key

    attribute {
      name = var.dynamodb_hash_key
      type = "S"
    }

    billing_mode = "PROVISIONED"
    read_capacity = var.dynamodb_read_capacity
    write_capacity = var.dynamodb_write_capacity
}
