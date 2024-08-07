data "aws_iam_policy_document" "lambda_policy" {
    statement {
      sid = "ReadWriteDynamoDB"
      effect = "Allow"
      actions = [
        "dynamodb:Scan",
        "dynamodb:PutItem"
        ]
        resources = [
            aws_dynamodb_table.table.arn
        ]
    }

    statement {
      sid = "AllowLogging"
      effect = "Allow"
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
        ]
        resources = ["*"]
    }
}

resource "aws_iam_policy" "lambda" {
    name = "lambda-policy-dw"
    policy = data.aws_iam_policy_document.lambda_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
    statement {
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        principals {
          type = "Service"
          identifiers = ["lambda.amazonaws.com"]
        }
    }
  
}

resource "aws_iam_role" "role" {
    name = "lambda-policy-role"
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json 
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
    role = aws_iam_role.role.name
    policy_arn = aws_iam_policy.lambda.arn
}

data "archive_file" "lambda_package" {
    type = "zip"
    source_dir = "../backend"
    output_path = "./backend_zip"
}

resource "aws_lambda_function" "lambda_function" {
    filename = "./backend_zip"
    function_name = "backend_dw"
    role = aws_iam_role.role.arn
    handler = "main.handler"
    runtime = "python3.8"
    source_code_hash = data.archive_file.lambda_package.output_base64sha256

    environment {
      variables = {
        TABLE_NAME = aws_dynamodb_table.table.name
      }
    }
}
