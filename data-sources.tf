data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "..."
    key    = "..."
    region = "..."
  }
}

data "terraform_remote_state" "load_balancers" {
  backend = "s3"
  config = {
    bucket = "..."
    key    = ".."
    region = ".."
  }
}

