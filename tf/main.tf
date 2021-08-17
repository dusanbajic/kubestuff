terraform {
  required_version = ">= 1.0.2"
}

provider "aws" {
  region  = var.aws_region
  profile = var.awscli_profile
}
