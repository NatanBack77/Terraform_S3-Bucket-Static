terraform {
  required_version = ">1.0.0"
  required_providers {
    aws = {
        source = ""
        version = ""
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
variable "bucket_name" {
  type = string
}

resource "aws_s3_bucket" "static_site_bucket" {
  bucket = "static_site-${var.bucket_name}"
  website {
    index_document = "index.html"
    error_document = "500.html"
  }

  tags = {
    Name= "Static Bucket"
    Environment= "Production"
  }

}
 resource "aws_s3_bucket_public_access_block" "static_site_bucket" {
    
   bucket = aws_s3_bucket.static_site_bucket.id

   block_public_acls = false
   block_public_policy = false
   ignore_public_acls = false
   restrict_public_buckets = false
 }