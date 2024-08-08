variable "api_gateway_name" {
    type = string
    description = "Nazwa API Gateway"
    sensitive = false // Określa czy zmienna powinna być jawna czy nie, ale w pliku stanu nadal jest wyświetlona w plain text.
    nullable = true
}

variable "lambda_payload_version" {
    type = string
    description = "Wersja zwrotki funkcji lambda"
    default = "2.0" // wpływa na to czy dana zmienna jest wymagana czy nie.
    nullable = false
}

variable "api_gateway_route_get" {
    type = object({
      http_method = string
      route = string 
    })
  description = "Ścieżka API GET (obiekt zawierający http_method i route)"
  nullable = false
}

variable "api_gateway_route_post" {
    type = object({
      http_method = string
      route = string
    })
    description = "Ścieżka API POST (obiekt zawierający http_method i route)"
    nullable = false
}

variable "dynamodb_name" {
    type = string
    description = "Nazwa DynamoDB"
    nullable = false
}

variable "dynamodb_hash_key" {
    type = string
    description = "Klucz główny DynamoDB"
    nullable = false
}

variable "dynamodb_read_capacity" {
    type = number
    description = "Ilość odczytów DynamoDB"
    default = 1
    nullable = false
}

variable "dynamodb_write_capacity" {
    type = number
    description = "Ilość zapisów DynamoDB"
    default = 1
    nullable = false
}

variable "lambda_policy" {
    type = string
    description = "Nazwa polityki używanej przez funkcję lambda"
    nullable = false
}

variable "lambda_role" {
    type = string
    default = "Nazwa execution role lambdy"
    nullable = false
}

variable "lambda_source_dir" {
    type = string
    description = "Ścieżka do kodu funkcji lambda"
    nullable = false
}

variable "lambda_source_file_name" {
    type = string
    description = "Nazwa zip z kodem lambdy"
    default = "lambda_source"    
    nullable = false
}

variable "lambda_function_name" {
    type = string
    description = "Nazwa funkcji lambda"
    nullable = false
}

variable "lambda_handler" {
    type = string
    description = "Uchwyt funkcji lambda"
    nullable = false
}

variable "s3_bucket_name" {
    type = string
    description = "Nazwa S3 bucket"
    nullable = false
}

variable "s3_public_access_block" {
    type = object({
        block_public_acls       = bool
        block_public_policy     = bool
        ignore_public_acls      = bool
        restrict_public_buckets = bool
    })
    description = "Blok publicznego dostępu S3"
    default = {
        block_public_acls = true
        block_public_policy = false
        ignore_public_acls = true
        restrict_public_buckets = false
    }
    nullable = false
}
