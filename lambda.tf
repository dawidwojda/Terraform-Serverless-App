data "aws_iam_policy_document" "lambda_policy" {
    dynamic "statement" {
        for_each = local.lambda_policy
        content {
            sid = statement.key
            effect = statement.value.effect
            actions = statement.value.actions
            resources = statement.value.resources
        }
    }
}

resource "aws_iam_policy" "lambda" {
    name = var.lambda_policy
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
    name = var.lambda_role
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json 
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
    role = aws_iam_role.role.name
    policy_arn = aws_iam_policy.lambda.arn
}

data "archive_file" "lambda_package" {
    type = "zip"
    source_dir = var.lambda_source_dir
    output_path = "./${var.lambda_source_file_name}_zip"
}

resource "aws_lambda_function" "lambda_function" {
    filename = "./${var.lambda_source_file_name}_zip"
    function_name = var.lambda_function_name
    role = aws_iam_role.role.arn
    handler = var.lambda_handler
    runtime = "python3.8"
    source_code_hash = data.archive_file.lambda_package.output_base64sha256

    environment {
      variables = {
        TABLE_NAME = aws_dynamodb_table.table.name
      }
    }
}

resource "aws_lambda_permission" "resource_based_policy" {
    statement_id = "HTTPApiInvoke"
    action  = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_function.function_name
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*"
}