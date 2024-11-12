terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.1"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.97.0"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region = var.aws_region
}

# Snowflake provider configuration
provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_user
  password = var.snowflake_password
}

