variable "aws_region" {
  description = "AWS region"
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI) ID"
  default     = "ami-0fc82f4dabc05670b"  # Replace with a valid AMI
}

variable "key_name" {
  description = "SSH Key pair name"
  default     = "myec2"
}
