terraform {
  backend "s3" {
    bucket         = "s3backend79939"  # Replace with your actual S3 bucket name
    key            = "global/terraform/terraform.tfstate"   # Path to store the state file
    region         = "us-east-2"                 # AWS region of the S3 bucket
    encrypt        = true                        # Encrypt state file using S3 encryption
}
}

provider "aws" {
  region = var.aws_region
}
