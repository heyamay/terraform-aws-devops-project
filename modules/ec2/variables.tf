# modules/ec2/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instances will be launched"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the EC2 instances will be launched"
  type        = list(string)
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0b09627181c8d5778"
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 1
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true # For public instances
}

variable "ec2_name_prefix" {
  description = "Prefix for the EC2 instance name tag"
  type        = string
  default     = "my-terraform-ec2"
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance"
  type        = string
  default     = "cicd_keypair" # Make sure this key pair exists in your AWS account
}

variable "security_group_ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH from anywhere"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP from anywhere"
    }
  ]
}
