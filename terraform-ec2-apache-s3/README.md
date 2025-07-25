# 🚀 Terraform EC2 + S3 Static Image Demo (Apache Server)

This project provisions an **EC2 instance running Apache** that serves a custom web page with a static image hosted in an **S3 bucket**. All infrastructure is deployed using **Terraform**, and a sample image is displayed by referencing it from S3.

---

## 📁 Project Structure

📦 terraform-ec2-apache-s3
├── main.tf                  # Main Terraform configuration (EC2, S3, IAM, Security Groups)
├── variables.tf             # Input variables (AMI ID, instance type, key name, etc.)
├── 
├── outputs.tf               # Outputs (like EC2 public IP)
├── user_data.sh             # EC2 bootstrap script (installs Apache, fetches S3 image)
├── s3_assets/
│   └── image.jpg            # Static image to upload to S3
├── screenshots/
│   ├── output_final.png     # EC2 Instance ip result
│   ├── pipeline_run.png        # Gitlab pipline
│   └
└── README.md                # Complete documentation of the project



---

## 🧩 What This Project Does

- Creates an **S3 bucket** and uploads an image to it
- Launches an **EC2 instance (Amazon Linux 2)** in a public subnet
- Installs **Apache web server** using `user_data.sh`
- Dynamically generates `index.html` referencing the image in S3
- Outputs the EC2 **public IP** to access the webpage

---

## 🌐 Web Page Preview

When deployed successfully, you’ll see:

```html
<h1>Deployed via Terraform on EC2 - KING GABBAR</h1>
<img src="https://<your-s3-bucket>.s3.amazonaws.com/sample-image.jpg" width="500">


 user_data.sh : for reference

 ---------------------
 yum install -y httpd
systemctl start httpd
systemctl enable httpd

cat <<EOF > /var/www/html/index.html
<html>
  <head><title>Apache + S3 Demo</title></head>
  <body>
    <h1>Deployed via Terraform on EC2 - KING GABBAR </h1>
    <img src="https://${s3_bucket_name}.s3.amazonaws.com/image.jpg" width="500" />
  </body>
</html>
EOF
