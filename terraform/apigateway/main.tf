resource "aws_api_gateway_rest_api" "api_fast_food" {
  name        = "MyAPI"
  description = "Minha API Gateway"
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_rest_api.api_fast_food.root_resource_id
  path_part   = "example"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.root.id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

resource "aws_api_gateway_deployment" "api_fast_food_deployment" {
  depends_on = [aws_api_gateway_integration.proxy]
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  stage_name = "dev"
}


# autorize

resource "aws_api_gateway_authorizer" "custom" {
  name                   = "custom-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.api_fast_food.id
  authorizer_uri         = var.lambda_authorizadora_invokearn
#  authorizer_credentials = "arn:aws:iam:us-east-1:734474252741:role/MyLambdaExecutionRole"
  authorizer_credentials = var.iam_role_invocation_role
#  identity_validation_expression = "Authorization"
  # type                   = "TOKEN"
  type                             = "REQUEST"
  identity_source                  = "method.request.header.Authorization"
  authorizer_result_ttl_in_seconds = 0
}