variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix used in all resource names and tags"
  type        = string
  default     = "auditsafely-labs"
}

variable "instance_type" {
  description = "EC2 instance type — t3.micro is free tier on new accounts"
  type        = string
  default     = "t3.micro"
}

variable "public_key_path" {
  description = "Absolute path to your SSH public key, e.g. /Users/you/.ssh/auditsafely-labs.pub"
  type        = string
}

variable "your_ip_cidr" {
  description = "Your home IP in CIDR notation, e.g. 203.0.113.42/32. Used to restrict SSH and app ports."
  type        = string
}
