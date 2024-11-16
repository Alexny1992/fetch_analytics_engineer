variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}
variable "bucket_name" {
  description = "fetch-s3-warehouse"
  type        = string
  default = "fetch-s3-warehouse"
}

variable "json_files" {
  description = "List of JSON files to upload"
  type        = list(string)
  default     = ["data/Brands.json", "data/Receipts.json", "data/users.json"]
}


# variable "snowflake_password" {
#   description = "The password for Snowflake"
#   type        = string
#   sensitive   = true  # mark as sensitive to prevent logging the password
# }

# variable "SNOWFLAKE_ACCOUNT" {
#   description = "The Snowflake account identifier"
#   type        = string
# }

# variable "SNOWFLAKE_REGION" {
#   description = "The Snowflake region"
#   type        = string
# }
