resource "aws_db_instance" "posgress" {
  engine = "postgres"
  multi_az = true
  iam_database_authentication_enabled  = true
  kms_key_id        = "arn:aws:kms:us-west-2:111122223333:key/example"
  storage_encrypted = true
  deletion_protection     = true
  publicly_accessible  = false
  enabled_cloudwatch_logs_exports  = ["audit", "error", "general", "slowquery"]
  monitoring_interval = 60
  performance_insights_enabled = true
  performance_insights_kms_key_id = "arn:aws:kms:us-west-2:1111111111:key/xyz"
  parameter_group_name = aws_db_parameter_group.posgress.name
}
#resource "aws_security_group" "sg-https" {
#  ingress {
#    description = "https"
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = "0.0.0.0/0"
#  }
#}
resource "aws_rds_cluster" "rds-cluster" {
  backup_retention_period = 5
  deletion_protection     = true
  engine_mode = "serverless"
  iam_database_authentication_enabled  = true
  kms_key_id        = "arn:aws:kms:us-west-2:111122223333:key/example"
  storage_encrypted = true
}

resource "aws_backup_selection" "example" {
    iam_role_arn = aws_iam_role.example.arn
    name         = "tf_example_backup_selection"
    plan_id      = aws_backup_plan.example.id
    resources = [
      aws_rds_cluster.rds-cluster.arn,
    ]
}

resource "aws_db_parameter_group" "posgress" {
  name        = "rds-cluster-pg"
  family      = "postgres"

  parameter {
    name  = "log_statement"
    value = "ddl"
  }
  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }
}