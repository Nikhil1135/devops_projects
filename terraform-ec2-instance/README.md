# ✅ Terraform EC2 Instance – CI/CD Project

## 📌 Project Overview
This project provisions a basic **EC2 instance** on AWS using **Terraform**, with a CI/CD pipeline implemented using **GitLab CI**. The Terraform code is developed in **GitHub Codespaces** and pushed to GitLab for automation.

---

## 🧰 Tools Used
- **Terraform**
- **AWS EC2**
- **GitHub Codespaces**
- **GitLab CI/CD**
- **Git**
- **GitLab Runner** (Shared/Personal)

---

## 🧱 Project Structure

```
terraform-ec2-instance/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── versions.tf
├── .gitlab-ci.yml
├── screenshots/
│   ├── pipeline-run.png
│   └── ec2-instance.png
└── README.md
```




---

## ⚙️ Features
- Launches a `t2.micro` EC2 instance in a selected region
- Uses variables and outputs for better flexibility
- GitLab CI pipeline automates Terraform tasks
- Easily extendable into modules or real infrastructure stacks

---

## 🚀 How to Use

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/Nikhil1135/devops_projects.git
cd devops_projects/terraform-ec2-instance

2️⃣ AWS Credentials Setup
Make sure you have AWS credentials configured via environment variables:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

For GitLab:

Add these as protected variables in GitLab CI/CD Settings


🧪 GitLab CI/CD Pipeline
This project includes .gitlab-ci.yml with stages to:

Run terraform init

Run terraform plan

Run terraform apply



===============================📸 Pipeline Screenshot==========================
<img width="1920" height="1032" alt="image" src="https://github.com/user-attachments/assets/7987ed5e-7832-4e32-a95b-0f4003aab181" />
===============================================================================


📌 Learnings
Hybrid workflow using GitHub for dev and GitLab for CI/CD

Hands-on Terraform EC2 provisioning

CI/CD pipeline design using GitLab stages

Managing cloud infrastructure as code


🚀 Future Improvements (Optional)
Add Security Group with port 22 open

Add user_data to configure Apache or NGINX

Add tls_private_key for SSH access

Use S3 backend with DynamoDB state locking

Break this into a reusable Terraform module


=======================
👨‍💻 Author
Nikhil Kumar Reddy

GitHub: @Nikhil1135
=======================
