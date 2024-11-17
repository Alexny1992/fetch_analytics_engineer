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


# variable "aws_key_id" {
#   description = "aws access key"
#   type = string
# }

# variable "aws_secret_key" {
#   description = "aws secret key"
#   type = string
# }