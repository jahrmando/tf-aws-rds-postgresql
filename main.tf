provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

data "aws_vpc" "selected" {
  default = true
}

data "aws_region" "selected" {}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    type-subnet = "public"
  }
}

locals {
  region = data.aws_region.selected.name

  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
  all_ipsv6    = ["::/0"]

  custom_tags = {
    Name        = "rds-${var.project}"
    Environment = var.env
  }
}

data "aws_iam_policy_document" "rds_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rds_monitoring_role" {
  name               = "rds-monitoring_role-${var.project}"
  path               = "/services/"
  assume_role_policy = data.aws_iam_policy_document.rds_instance_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_subnet_group" "selected" {
  name       = "default-${data.aws_vpc.selected.id}"
  subnet_ids = data.aws_subnet_ids.selected.ids
  tags       = local.custom_tags
}

resource "aws_db_instance" "default" {
  identifier     = var.project
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  skip_final_snapshot                 = var.skip_final_snapshot
  apply_immediately                   = var.apply_immediately
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  deletion_protection                 = var.deletion_protection
  monitoring_interval                 = var.monitoring_interval
  monitoring_role_arn                 = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled        = true
  customer_owned_ip_enabled           = false
  enabled_cloudwatch_logs_exports     = ["postgresql"]
  iam_database_authentication_enabled = false
  storage_type                        = "gp3"
  iops                                = 3000 # Minimum value for GP3
  storage_encrypted                   = true

  db_subnet_group_name   = aws_db_subnet_group.selected.id
  vpc_security_group_ids = [aws_security_group.selected.id]
  multi_az               = var.multi_az
  port                   = var.service_port
  publicly_accessible    = var.publicly_accessible

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  username = var.master_username
  password = var.master_password

  # Storage Autoscaling
  allocated_storage     = 20
  max_allocated_storage = 1000
}

resource "aws_security_group" "selected" {
  name        = "RDSAccess-${var.project}"
  description = "Access to Postgresql ${var.project}"
  vpc_id      = data.aws_vpc.selected.id
  tags        = local.custom_tags
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.selected.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_access" {
  type              = "ingress"
  security_group_id = aws_security_group.selected.id

  from_port   = var.service_port
  to_port     = var.service_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_access_ipv6" {
  type              = "ingress"
  security_group_id = aws_security_group.selected.id

  from_port        = var.service_port
  to_port          = var.service_port
  protocol         = local.tcp_protocol
  ipv6_cidr_blocks = local.all_ipsv6
}
