vpc_cidr                = "10.0.0.0/16"
environment             = "dev"
region                  = "us-east-1"
create_bastion_endpoint = false
private_zone_name       = "example.internal"
cname_record_name       = "app"
cname_record_value      = "example.com"