# main.tf (Root Module)

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a compatible version
    }
  }

  # Backend for State Management on AWS S3
  backend "s3" {
    bucket         = "amay-terraform-statefile-bucket" # Replace with your unique S3 bucket name
    key            = "terraform-aws-project/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "amay-terraform-lock-table" # Optional: for state locking
  }
}

provider "aws" {
  region = var.aws_region
}

# --- Module Calls ---

module "vpc" {
  source = "./modules/vpc"

  vpc_name = "${var.project_name}-vpc"
  # You can override module variables here if needed
  # vpc_cidr_block = var.root_vpc_cidr_block
}

module "ec2_public" {
  source = "./modules/ec2"

  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.public_subnet_ids
  instance_type               = "t2.micro"
  ami_id                      = "ami-0b09627181c8d5778" # Replace with the AMI ID you found for ap-south-1
  instance_count              = 2
  associate_public_ip_address = true
  ec2_name_prefix             = "${var.project_name}-public-ec2"
  ssh_key_name                = "cicd_keypair" # Make sure this key pair exists in your AWS account

  security_group_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Be cautious with 0.0.0.0/0 for SSH in production
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

module "ec2_private" {
  source = "./modules/ec2"

  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.private_subnet_ids
  instance_type               = "t2.micro"
  ami_id                      = "ami-0b09627181c8d5778" # Replace with the AMI ID you found for ap-south-1
  instance_count              = 1
  associate_public_ip_address = false # Private instances
  ec2_name_prefix             = "${var.project_name}-private-ec2"
  ssh_key_name                = "cicd_keypair" # Make sure this key pair exists in your AWS account

  security_group_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"] # Allow SSH only from within the VPC (e.g., from public instances or bastion)
      description = "Allow SSH from VPC"
    }
  ]
}
