resource "aws_db_instance" "default" {
  identifier        = var.identifier
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  name     = var.db_name
  username = var.username
  password = var.password

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.default.name

  parameter_group_name = var.parameter_group_name
  multi_az             = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot = var.skip_final_snapshot

  tags = var.tags
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.identifier}-subnet-group-rt"
  subnet_ids = var.subnet_ids
   lifecycle {
    ignore_changes = [name]
  }
  }