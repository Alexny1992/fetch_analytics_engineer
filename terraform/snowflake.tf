
resource "snowflake_stage" "S3_TO_SNOWFLAKE" {
  for_each    = snowflake_file_format.json_format
  name        = "S3_TO_SNOWFLAKE"
  url         = "s3://fetch-s3-warehouse"
  database    = "FETCH_S3_DATABASE"
  schema      = "PUBLIC"
  storage_integration = snowflake_storage_integration.s3_integration.name
  # credentials = "AWS_KEY_ID='${var.aws_key_id}' AWS_SECRET_KEY='${var.aws_secret_key}'"
  file_format = each.value.name
}
resource "snowflake_storage_integration" "s3_integration" {
  name                      = "MY_S3_INTEGRATION"
  storage_provider          = "S3"
  storage_aws_role_arn      = "arn:aws:iam::825765414250:role/s3_snowflake_role"
  storage_allowed_locations = ["s3://fetch-s3-warehouse"]
  enabled                   = true
}

resource "snowflake_file_format" "json_format" {
  for_each    = toset(var.json_files) //Loop over each json files from variable
  name        = "json_format_${each.key}" //Making sure unique names for each format
  database    = "FETCH_S3_DATABASE"
  schema      = "PUBLIC"
  format_type = "JSON"
}

resource "snowflake_pipe" "json_pipe" {
  for_each = snowflake_stage.S3_TO_SNOWFLAKE
  database = "FETCH_S3_DATABASE"
  schema   = "PUBLIC"
  name     = "pipe_${replace(each.key, "/", "_")}"

  comment  = "Move Json files from S3 to Snowflake"
  copy_statement = <<SQL
    COPY INTO @FETCH_S3_DATABASE.PUBLIC.${each.value.name}
    FROM @${each.value.name}
    FILE_FORMAT = (FORMAT_NAME = '${snowflake_file_format.json_format[each.key].name}');
  SQL
}

