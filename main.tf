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
}

module "lambda" {
  source       = "./terraform/lambda"
  iam_role_arn = module.iam.iam_role_arn
}

