region                 = "us-west-2"
vpc_cidr               = "10.0.0.0/16"
environment            = "dev"
create_bastion_endpoint = true
private_zone_name      = "example.internal"
cname_record_name      = "myapp"
cname_record_value     = "internal-lb.example.com"