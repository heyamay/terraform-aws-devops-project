# modules/ec2/outputs.tf

output "instance_ids" {
  description = "List of IDs of the EC2 instances"
  value       = [for inst in aws_instance.web : inst.id]
}

output "instance_public_ips" {
  description = "List of public IPs of the EC2 instances"
  value       = [for inst in aws_instance.web : inst.public_ip]
}

output "security_group_id" {
  description = "The ID of the security group created for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}
