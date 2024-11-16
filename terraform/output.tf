output "s3_bucket_name" {
  value = aws_s3_bucket.fetch-s3-warehouse.bucket
}

# output "external_id" {
#   value = snowflake_storage_integration.s3_integration.external_id
#   description = "The external ID for configuring AWS IAM trust relationship."
# }
