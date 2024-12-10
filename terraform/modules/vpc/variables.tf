variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "create_bastion_endpoint" {
  description = "Whether to create a bastion endpoint"
  type        = bool
  default     = false
}

variable "private_zone_name" {
  description = "The name of the private DNS zone"
  type        = string
}

variable "cname_record_name" {
  description = "The name of the CNAME record"
  type        = string
}

variable "cname_record_value" {
  description = "The value of the CNAME record"
  type        = string
}