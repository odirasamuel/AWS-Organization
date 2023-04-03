terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9"
    }
  }
  backend "s3" {
    bucket         = "odi-tf-state-bucket"
    dynamodb_table = "odi-tf-state-lock"
    key            = "odi-tf-state/security-tooling"
    encrypt        = true
    profile        = "odira"
    region         = "us-east-2"
  }
}