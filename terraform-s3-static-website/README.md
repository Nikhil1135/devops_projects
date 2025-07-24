🚀 Static Website Hosting on AWS S3 using Terraform + GitLab CI/CD

Project outcome -   This project automates the deployment of a static website on AWS S3 using Terraform, integrated with GitLab CI/CD for continuous delivery and optional teardown.

📁 Project Structure :
.
├── main.tf                    
├── variables.tf               
├── website/index.html        
├── .gitlab-ci.yml        



✅ What This Project Does
>> Provisions an S3 bucket for static website hosting
>> Uploads an index.html file to the bucket
>> Makes the bucket publicly accessible
>> Defines an S3 bucket policy to allow public GetObject access
>> Uses GitLab CI/CD to automate:
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy (manual trigger)

🔧 Terraform Configuration Highlights :

1. website {} block
---------------------------------------------------------------------
website {
  index_document = "index.html"
}
📌 Purpose: Tells AWS to serve index.html as the root of the static site.
⚠️ Note: This does not refer to any folder named website. It’s part of S3’s website hosting feature.
---------------------------------------------------------------------
2. S3 Public Access Configuration :
resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

✅ This removes S3 public access restrictions, which are enabled by default in most AWS accounts.

❗ Without this, Terraform throws a 403 AccessDenied error when applying the bucket policy.
----------------------------------------------------------------------------------------------------
3. Bucket Policy to Allow Public Access :

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.allow_public]
}

✅ jsonencode() converts HCL to a valid JSON string as required by AWS S3.

✅ depends_on ensures this runs after public access block is relaxed.
-----------------------------------------------------------------------------------------------------

 Accessing Your Website :


http://<your-bucket-name>.s3-website-<region>.amazonaws.com/
------------------------------------------------------------------------------------------------------
✅ Summary of Mistakes You Fixed :

❌ Mistake	                                                                    ✅ Fix
Applied bucket policy before allowing public access	                              Added aws_s3_bucket_public_access_block and depends_on
Got 403 on terraform apply	                                                      Fixed block_public_policy to false
Destroy stage greyed out	                                                      Updated only: main in .gitlab-ci.yml
Confused website {} block with folder	                                          Understood it's for S3 hosting, not directory
------------------------------------------------------------------------------------------------------
🔚 Final Tips
Don’t skip the aws_s3_bucket_public_access_block if public access is required.

Always use jsonencode() when writing IAM policies in Terraform.

Double-check branch names when using only: in GitLab pipelines.
--------------------------------------------------------------------------------------------------------
👨‍💻 Author
Nikhil Kumar Reddy

GitHub: @Nikhil1135
=======================