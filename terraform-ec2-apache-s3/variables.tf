variable "region" {
  default = "us-east-1"
}
variable "s3_bucket_name" {
  default =  "my-static-assets-bucket-unique123"
}
variable "ami_id" {
  default = "ami-05ffe3c48a9991133"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
    description = "EC2 key pair name"
    default = "demo-1"
}