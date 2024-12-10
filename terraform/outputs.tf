output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_cidr" {
  value       = var.vpc_cidr
  description = "The CIDR block of the VPC"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "List of IDs of private subnets"
}

output "bastion_endpoint_id" {
  value       = module.vpc.bastion_endpoint_id
  description = "The ID of the bastion VPC endpoint"
}

output "private_hosted_zone_id" {
  value       = module.vpc.private_hosted_zone_id
  description = "The ID of the private hosted zone"
}

output "cname_record_fqdn" {
  value       = module.vpc.cname_record_fqdn
  description = "The FQDN of the CNAME record"
}

output "vpc_flow_log_id" {
  value       = module.vpc.vpc_flow_log_id
  description = "The ID of the VPC Flow Log"
}

# Remove the following output
# output "route53_query_log_id" {
#   value       = module.vpc.route53_query_log_id
#   description = "The ID of the Route 53 Query Log"
# }