output "lambda_authorizadora_invokearn" {
  value = aws_lambda_function.lambda_authorizadora.invoke_arn
}

output "lambda_authorizadora_function_name" {
  value = aws_lambda_function.lambda_authorizadora.function_name
}