variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}
variable "bucket_name" {
  description = "fetch-s3-warehouse"
  type        = string
  default     = "fetch-s3-warehouse"
}

variable "json_files" {
  description = "List of JSON files to upload"
  type        = list(string)
  default     = ["data/Brands.json", "data/Receipts.json", "data/users.json"]
}

variable "json_files_list" {
  description = "List of JSON files for snowflake pipline"
  type        = list(string)
  default     = ["Brands.json", "Receipts.json", "users.json"]
}

variable "aws_account_id" {
  description = "aws account id"
  type        = string
}

variable "snowflake_userID" {
  description = "snowflake userID"
  type        = string
}

variable "snowflake_externalID" {
  description = "snowflake externalID"
  type        = string
}
variable "snowflake_s3_policy_arn" {
  description = "snowflake s3 policy arn"
  type        = string
}

variable "aws_attached_role_arn" {
  description = "aws attached role arn"
  type        = string
}


# variable "aws_key_id" {
#   description = "aws access key"
#   type = string
# }

# variable "aws_secret_key" {
#   description = "aws secret key"
#   type = string
# }

# variable "storage_aws_role_arn"{
#   description = "storage_aws_role_arn"
#   type        = "string"
# }

