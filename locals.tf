locals {
  mime_types = {
    html = "text/html"
    css = "text/css"
    js = "text/javascript"
  }

  lambda_policy = {
    ReadWriteDynamoDB = {
        effect = "Allow"
        actions = [
              "dynamodb:Scan",
              "dynamodb:PutItem"
            ]
            resources = [
              aws_dynamodb_table.table.arn
        ]
    }
    AllowLogging = {
        effect = "Allow"
        actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
        ]
        resources = ["*"]
    }
  }
}