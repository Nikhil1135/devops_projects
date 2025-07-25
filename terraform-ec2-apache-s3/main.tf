provider "aws" {
  region = var.region
}

# S3 Bucket
resource "aws_s3_bucket" "static_assets" {
  bucket = var.s3_bucket_name
  force_destroy = true

  tags = {
    Name = "Static Assets Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.static_assets.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_assets.id


#You want to convert HCL to a JSON string, so use jsonencode():
  policy = jsonencode({            
  Version = "2012-10-17"
  Statement = [
  {
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.static_assets.arn}/*"
      }
  ]
  

  })

  depends_on = [aws_s3_bucket_public_access_block.block]
}

# Upload sample image to S3
resource "aws_s3_object" "image" {
  bucket = aws_s3_bucket.static_assets.id
  key    = "image.jpg"
  source = "s3_assets/image.jpg"
  #acl    = "public-read"
  content_type = "image/jpeg"
}

# Security Group
resource "aws_security_group" "apache_sg" {
  name        = "apache-sg"
  description = "Allow HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {     
  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  
}

# EC2 Instance
resource "aws_instance" "apache" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.apache_sg.id]


  user_data = templatefile("${path.module}/user_data.sh", {
    s3_bucket_name = var.s3_bucket_name
  })

  tags = {
    Name = "ApacheServer"
  }
}

