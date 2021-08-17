variable "project_name" {
  description = "Name of the project, all resources will be tagged with this name"
}

variable "project_owner" {
  description = "Name of the project owner, all resources will be tagged with this name"
}

variable "aws_region" {
  description = "AWS region to launch resources"
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR"
}

variable "public_subnets" {
  description = "Public subnets cidrs"
}

variable "private_subnets" {
  description = "Private subnets cidrs"
}

variable "azs" {
  description = "Availability zones"
}

variable "awscli_profile" {
  description = "awscli credentials profile"
}

