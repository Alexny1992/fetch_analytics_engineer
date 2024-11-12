variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "fetch-s3-database"
  type        = string
  default = "fetch-s3-database"
}

variable "json_files" {
  description = "List of JSON files to upload"
  type        = list(string)
  default     = ["data/Brands.json", "data/Receipts.json", "data/users.json"]
}

# Snowflake credentials (store these securely in production)
variable "snowflake_account" {
  description = "Snowflake account name"
  type        = string
}

variable "snowflake_user" {
  description = "Snowflake username"
  type        = string
}

variable "snowflake_password" {
  description = "Snowflake password"
  type        = string
}

variable "snowflake_database" {
  description = "Snowflake database name"
  type        = string
}

