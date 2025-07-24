resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name

#  What does website {} do?
# The website {} block is a configuration that tells AWS:
# “Treat this S3 bucket like a static website, and when someone visits the root URL, serve index.html.”

  website {                             
    index_document = "index.html"
  }

  tags = {
    Name        = "StaticWebsite"
    
  }
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_site.id


#You want to convert HCL to a JSON string, so use jsonencode():
  policy = jsonencode({            
  Version = "2012-10-17"
  Statement = [
  {
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.static_site.arn}/*"
      }
  ]
  

  })

  depends_on = [aws_s3_bucket_public_access_block.allow_public]
}

resource "aws_s3_object" "index_file" {
  bucket = aws_s3_bucket.static_site.id
  key = "index.html"
  source = "website/index.html"
  content_type = "text/html"
  #acl = "public-read"
}

