resource "aws_lambda_function" "lambda_authorizadora" {
  function_name = "lambda_authorizadora"
  role          = var.iam_role_arn
  runtime       = "java17"
  filename      = "LambdaAuthorizer-1.0.jar"
  handler       = "br.com.fiap.postech.LambdaHandler::handleRequest"
  memory_size   = 512
  timeout       = 15
}