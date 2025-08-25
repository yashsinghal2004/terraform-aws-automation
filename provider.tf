terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "terraform-aws-automation"
      Environment = var.environment
      Owner       = var.owner
    }
  }
}