#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create custom index.html with S3 image
cat <<EOF > /var/www/html/index.html
<html>
  <head><title>Apache + S3 Demo</title></head>
  <body>
    <h1>Deployed via Terraform on EC2 -KING GABBAR </h1>
    <img src="https://${s3_bucket_name}.s3.amazonaws.com/image.jpg" width="500" />
  </body>
</html>
EOF
