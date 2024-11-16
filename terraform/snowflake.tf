
resource "snowflake_stage" "s3_stage" {
  name        = "s3_stage"
  url         = "s3://fetch-s3-warehouse/"
  database    = "FETCH_S3_DATABASE"
  schema      = "PUBLIC"
  storage_integration   = snowflake_storage_integration.s3_integration.name
}

resource "snowflake_storage_integration" "s3_integration" {
  name                      = "MY_S3_INTEGRATION"
  storage_provider          = "S3"
  storage_aws_role_arn      = "arn:aws:iam::825765414250:role/s3_snowflake_role"
  storage_allowed_locations = ["s3://fetch-s3-warehous"]
  enabled                   = true
}
