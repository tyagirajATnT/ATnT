output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "bastion_endpoint_id" {
  value = var.create_bastion_endpoint ? aws_vpc_endpoint.bastion[0].id : null
}

output "private_hosted_zone_id" {
  value = aws_route53_zone.private.zone_id
}

output "cname_record_fqdn" {
  value = aws_route53_record.cname.fqdn
}

output "vpc_flow_log_id" {
  value = aws_flow_log.main.id
}

# Remove the following output as it no longer exists
# output "route53_query_log_id" {
#   value = aws_route53_query_log.main.id
# }