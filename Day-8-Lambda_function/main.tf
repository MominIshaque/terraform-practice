provider "aws" {
  region = "us-east-1"
}

# 1. IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# 2. Attach AWS managed policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 3. Create Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name = "my-terraform-lambda"
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler" # Inside zip file
  role          = aws_iam_role.lambda_exec_role.arn

  filename         = "function.zip"
  source_code_hash = filebase64sha256("function.zip")
}
