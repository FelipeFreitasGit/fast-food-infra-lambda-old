terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "iam" {
  source = "./terraform/iam"
  lambda_authorizadora_function_name = module.lambda.lambda_authorizadora_function_name
  execution_arn = module.apigateway.execution_arn
}

module "lambda" {
  source       = "./terraform/lambda"
  iam_role_arn = module.iam.iam_role_arn
}

module "apigateway" {
  source = "./terraform/apigateway"
  lambda_authorizadora_invokearn = module.lambda.lambda_authorizadora_invokearn
  iam_role_arn = module.iam.iam_role_arn
}

