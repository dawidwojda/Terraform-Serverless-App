resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
}


resource "aws_s3_bucket_public_access_block" "public_accesss" {
  count = 3
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.s3_public_access_block.block_public_acls
  block_public_policy     = var.s3_public_access_block.block_public_policy
  ignore_public_acls      = var.s3_public_access_block.ignore_public_acls
  restrict_public_buckets = var.s3_public_access_block.restrict_public_buckets
}

data "aws_iam_policy_document" "bucket_policy" {
    statement {
      sid = "AllowPublic"
      effect = "Allow"
      actions = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.bucket.arn}/*"]
      principals {
        type = "*"
        identifiers = ["*"]
      }
    }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.bucket.id
    policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_s3_object" "object" {
  for_each = fileset("frontend/build", "**")
  bucket = aws_s3_bucket.bucket.id
  key = each.value
  source = "frontend/build/${each.value}"
  etag = filemd5("frontend/build/${each.value}")
  content_type = lookup(local.mime_types, regex("[^.]+$", each.value), null) 
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
  
}