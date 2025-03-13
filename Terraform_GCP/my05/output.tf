output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.private_subnet.id
}

output "ec2_instance_ids" {
  description = "EC2 Instance IDs"
  value       = aws_instance.web[*].id
}

output "ec2_public_ips" {
  description = "EC2 Public IPs"
  value       = aws_instance.web[*].public_ip
}
