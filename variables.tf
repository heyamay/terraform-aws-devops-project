# variables.tf (Root Module)

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name for the project, used as a prefix for resources"
  type        = string
  default     = "devops-project"
}
