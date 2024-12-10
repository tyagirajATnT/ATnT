terraform {
  backend "s3" {
    bucket = "atntrtbucket"
    key    = "modules/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                = var.vpc_cidr
  environment             = var.environment
  region                  = var.region
  create_bastion_endpoint = var.create_bastion_endpoint
  private_zone_name       = var.private_zone_name
  cname_record_name       = var.cname_record_name
  cname_record_value      = var.cname_record_value
}

module "rds" {
  source = "./modules/rds"

  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_ids             = module.vpc.private_subnet_ids
  parameter_group_name   = var.parameter_group_name
  multi_az               = var.multi_az
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window
  skip_final_snapshot    = var.skip_final_snapshot
  tags                   = var.tags
}