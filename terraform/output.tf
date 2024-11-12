output "s3_bucket_name" {
  value = aws_s3_bucket.fetch-s3-database.bucket
}

output "fetch_json_files" {
  value = [for obj in aws_s3_object.json_files : obj.key]  
  description = "List of JSON file names uploaded to the S3 bucket"
}