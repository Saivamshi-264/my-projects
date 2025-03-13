provider "aws" {
  region     = "ap-southeast-2"
}

resource "aws_vpc" "sai_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = "sai-vpc" }
}

resource "aws_subnet" "sai_public_subnet" {
  vpc_id                  = aws_vpc.sai_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-2a"
  tags = { Name = "sai-public-subnet" }
}



resource "aws_internet_gateway" "TF_igw" {
  vpc_id = aws_vpc.sai_vpc.id
  tags = { Name = "TF-igw" }
}

resource "aws_route_table" "sai_route_table" {
  vpc_id = aws_vpc.sai_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TF_igw.id
  }
  tags = { Name = "sai-route-table" }
}

resource "aws_route_table_association" "sai_public_assoc" {
  subnet_id      = aws_subnet.sai_public_subnet.id
  route_table_id = aws_route_table.sai_route_table.id
}

resource "aws_security_group" "sai_batch_sg" {
  vpc_id = aws_vpc.sai_vpc.id
  name   = "sai-batch-sg"

  ingress {
    from_port   = 0
    to_port     = 65535
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

resource "aws_iam_role" "sai_batch_service_role" {
  name = "sai-batch-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "batch.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "sai_batch_service_policy" {
  role       = aws_iam_role.sai_batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

resource "aws_s3_bucket" "sai_input_bucket" {
  bucket = "sai7993-input-bucket"
}

resource "aws_s3_bucket" "sai_output_bucket" {
  bucket = "sai7993-output-bucket"
}

resource "aws_iam_role" "batch_role" {
  name = "sai-batch-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "batch_instance_profile" {
  name = "sai-batch-instance-profile"
  role = aws_iam_role.batch_role.name
}


resource "aws_batch_compute_environment" "sai_compute_env" {
  compute_environment_name = "sai-compute-env"
  type                     = "MANAGED"

  compute_resources {
    type              = "EC2"
    min_vcpus        = 0
    max_vcpus        = 2
    desired_vcpus    = 1
    instance_type   = ["m5.large"]
    subnets         = [aws_subnet.sai_public_subnet.id]
    security_group_ids = [aws_security_group.sai_batch_sg.id]
    instance_role    = aws_iam_instance_profile.batch_instance_profile.arn
  }
  service_role = aws_iam_role.sai_batch_service_role.arn
}

resource "aws_batch_job_queue" "sai_job_queue" {
  name     = "sai-job-queue"
  state    = "ENABLED"
  priority = 1
  compute_environment_order {
    order  = 1
    compute_environment = aws_batch_compute_environment.sai_compute_env.arn
  }
}

resource "aws_batch_job_definition" "sai_job_definition" {
  name                  = "sai-job-definition"
  type                  = "container"
  container_properties  = <<EOF
{
  "image": "amazonlinux",
  "command": ["echo", "Hello World"],
  "memory": 512,
  "vcpus": 1
}
EOF
}



output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.sai_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = aws_subnet.sai_public_subnet.id
}


output "internet_gateway_id" {
  description = "The ID of the internet gateway."
  value       = aws_internet_gateway.TF_igw
}

output "route_table_id" {
  description = "The ID of the route table."
  value       = aws_route_table.sai_route_table.id
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.sai_batch_sg.id
}

output "batch_compute_environment_arn" {
  description = "The ARN of the AWS Batch compute environment."
  value       = aws_batch_compute_environment.sai_compute_env.arn
}

output "batch_job_queue_arn" {
  description = "The ARN of the AWS Batch job queue."
  value       = aws_batch_job_queue.sai_job_queue.arn
}

output "batch_job_definition_arn" {
  description = "The ARN of the AWS Batch job definition."
  value       = aws_batch_job_definition.sai_job_definition.arn
}

output "s3_input_bucket_name" {
  description = "The name of the S3 input bucket."
  value       = aws_s3_bucket.sai_input_bucket.bucket
}

output "s3_output_bucket_name" {
  description = "The name of the S3 output bucket."
  value       = aws_s3_bucket.sai_output_bucket.bucket
}

output "batch_service_role_arn" {
  description = "The ARN of the Batch service role."
  value       = aws_iam_role.sai_batch_service_role.arn
}
