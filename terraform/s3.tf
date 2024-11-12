# S3 bucket creation
resource "aws_s3_bucket" "fetch-s3-database" {
  bucket = "fetch-s3-database"
}

resource "aws_s3_bucket_ownership_controls" "fetch-s3-database" {
  bucket = aws_s3_bucket.fetch-s3-database.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "fetch-s3-database" {
  depends_on = [aws_s3_bucket_ownership_controls.fetch-s3-database]

  bucket = aws_s3_bucket.fetch-s3-database.id
  acl    = "private"
}

# Upload each JSON file to the S3 bucket
resource "aws_s3_object" "json_files" {
  for_each    = toset(var.json_files)
  bucket      = aws_s3_bucket.fetch-s3-database.bucket
  key         = basename(each.value)       
  source      = each.value                
  content_type = "application/json"
}