provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Owner   = var.owner
      Project = "sophie-api-gateway-module"
    }
  }
}