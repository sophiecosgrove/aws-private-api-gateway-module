terraform {
  required_providers {
    aws = {
      version = ">=3.22.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "sophie-module-terraform-state"
    key    = "terraform/services/api-gateway/terraform.tfstate"
    region = "eu-west-1"
    acl    = "bucket-owner-full-control"
  }
}