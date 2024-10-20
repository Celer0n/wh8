terraform {
  required_version = "1.9.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
  backend "s3" {
    profile                  = "default"
    shared_credentials_files = ["~/.aws/credentials"]
    bucket                   = "terraform-back-17-09"
    region                   = "eu-central-1"
    key                      = "AWS/Ansible/terraform.tfstate"
    dynamodb_table           = "terdynamodb"
  }
}