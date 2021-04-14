data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    profile        = "profile"
    region         = "us-east-1"
    bucket         = "bucket"
    key            = "terraform/dev/vpc.tfstate"
    dynamodb_table = "profile-tfstate-lock"
    encrypt        = true
  }
}

data "aws_region" "current_region" {}

data "aws_caller_identity" "current_caller" {}