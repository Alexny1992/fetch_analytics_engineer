terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.75.1"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.98.0"
    }
  }
}


# AWS provider configuration
provider "aws" {
  region = var.aws_region
  // .env file 
  // AWS_ACCESS_KEY_ID
  // AWS_SECRET_ACCESS_KEY
  // AWS_DEFAULT_REGION
}

provider "snowflake" {
  role = "ACCOUNTADMIN"
  // SNOWFLAKE_ORGANIZATION_NAME
  // SNOWFLAKE__ACCOUNT_NAME
  // SNOWFLAKE_USER
  // SNOWFLAKE_AUTHENTICATOR
  // SNOWFLAKE_PRIVATE_KEY  
  // Are all in .env
}
