resource "snowflake_stage" "S3_TO_SNOWFLAKE" {
  name                = "S3_TO_SNOWFLAKE"
  url                 = "s3://fetch-s3-warehouse/"
  database            = "FETCH_S3_DATABASE"
  schema              = "PUBLIC"
  storage_integration = snowflake_storage_integration.s3_integration.name
}
resource "snowflake_storage_integration" "s3_integration" {
  name                      = "MY_S3_INTEGRATION"
  storage_provider          = "S3"
  storage_aws_role_arn      = var.aws_attached_role_arn
  storage_allowed_locations = ["s3://fetch-s3-warehouse"]
  enabled                   = true
}

resource "snowflake_file_format" "json_format" {
  for_each    = local.json_files_map 
  name        = each.value
  database    = "FETCH_S3_DATABASE"
  schema      = "PUBLIC"
  format_type = "JSON"
  lifecycle {
    ignore_changes = [
      name,
    ]
  }
}

# resource "snowflake_pipe" "json_pipe" {
#   for_each = snowflake_stage.S3_TO_SNOWFLAKE
#   database = "FETCH_S3_DATABASE"
#   schema   = "PUBLIC"
#   name     = "json_pipe"

#   comment  = "Move Json files from S3 to Snowflake"
#   copy_statement = <<SQL
#     COPY INTO @FETCH_S3_DATABASE.PUBLIC
#     FROM @${each.value.name};
#   SQL
# }
