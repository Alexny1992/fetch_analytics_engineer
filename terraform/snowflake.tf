# Create a Snowflake database
resource "snowflake_database" "fetch-data-schema" {
  name    = "fetch-data-schema"
  comment = "brands json files/ receipts json files/ users json files"
}
