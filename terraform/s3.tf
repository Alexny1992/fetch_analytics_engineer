resource "aws_s3_bucket" "fetch-s3-warehouse" {
  bucket = "fetch-s3-warehouse"
}

resource "aws_s3_bucket_ownership_controls" "fetch-s3-warehouse" {
  bucket = aws_s3_bucket.fetch-s3-warehouse.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "fetch-s3-warehouse" {
  depends_on = [aws_s3_bucket_ownership_controls.fetch-s3-warehouse]

  bucket = aws_s3_bucket.fetch-s3-warehouse.id
  acl    = "private"
}

# Upload each JSON file to the S3 bucket
resource "aws_s3_object" "json_files" {
  for_each     = toset(var.json_files)
  bucket       = aws_s3_bucket.fetch-s3-warehouse.bucket
  key          = basename(each.value)
  source       = each.value
  content_type = "application/json"
}

resource "aws_iam_policy" "snowflake_s3_access_policy" {
  name        = "snowflake-s3-access-policy"
  description = "Policy for Snowflake to access S3 bucket for data loading"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        Resource = [
          "arn:aws:s3:::fetch-s3-warehouse",
          "arn:aws:s3:::fetch-s3-warehouse/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "snowflake_role" {
  name = "SnowflakeIntegrationRole"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": var.snowflake_user_arn
        },
        "Action": "sts:AssumeRole",
        "Condition": {
          "StringEquals": {
            // Using DESCRIBE STAGE in Snowflake to get external ID;
            "sts:ExternalId": var.snowflake_externalID
          }
        }
      }
    ]
  })
}

//attach snowflake role to s3 access policy
resource "aws_iam_role_policy_attachment" "snowflake_policy_attachment" {
  role       = aws_iam_role.snowflake_role.name
  policy_arn = var.snowflake_s3_policy_arn
}

