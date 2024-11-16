terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.75.1"
    }    
    snowflake = {
    source  = "Snowflake-Labs/snowflake"
    version = "~> 0.87"
    }
  }
}


# AWS provider configuration
provider "aws" {
  region = var.aws_region
}

provider "snowflake" {
  role = "SYSADMIN"
}

resource "snowflake_database" "db" {
  name = "TF_DEMO"
}

resource "snowflake_warehouse" "warehouse" {
  name           = "TF_DEMO"
  warehouse_size = "xsmall"
  auto_suspend   = 60
}