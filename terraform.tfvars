# API Gateway
api_gateway_name = "api"
lambda_payload_version = "2.0" // jest domyślna ale można intencjonalne wskazywać, że specjalnie używamy tej wersji
api_gateway_route_get = {
  http_method = "GET"
  route = "/"
}
api_gateway_route_post = {
  http_method = "POST"
  route = "/"
}

# DynamoDB
dynamodb_name = "comments"
dynamodb_hash_key = "mail"
dynamodb_read_capacity = 1
dynamodb_write_capacity = 1

# Lambda
lambda_policy = "lambda-policy-dw"
lambda_role = "lambda-policy-role"
lambda_source_dir = "../backend"
lambda_source_file_name = "backend"
lambda_function_name = "backend_dw"
lambda_handler = "main.handler"

# S3
s3_bucket_name = "frontend-dw"
s3_public_access_block = {
  block_public_acls = true
  block_public_policy = false
  ignore_public_acls = true
  restrict_public_buckets = false
}
