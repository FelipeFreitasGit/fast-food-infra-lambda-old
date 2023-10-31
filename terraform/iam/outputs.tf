output "iam_role_arn" {
  value = aws_iam_role.lambda.arn
}

output "iam_role_invocation_role" {
  value = aws_iam_role.invocation_role.arn
}