# outputs.tf (Root Module)

output "vpc_id" {
  description = "The ID of the provisioned VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "public_instance_ips" {
  description = "Public IP addresses of the public EC2 instances"
  value       = module.ec2_public.instance_public_ips
}

output "public_instance_ids" {
  description = "IDs of the public EC2 instances"
  value       = module.ec2_public.instance_ids
}

output "private_instance_ids" {
  description = "IDs of the private EC2 instances"
  value       = module.ec2_private.instance_ids
}
