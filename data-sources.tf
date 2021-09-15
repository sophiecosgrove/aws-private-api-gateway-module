data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "sophie-tf-state"
    key    = "terraform/account/environment/infrastructure/vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "load_balancers" {
  backend = "s3"
  config = {
    bucket = "sophie-tf-state"
    key    = "terraform/account/environment/services/load-balancers/terraform.tfstate"
    region = "eu-west-1"
  }
}

