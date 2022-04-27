resource "aws_rds_cluster" "test" {
  backup_retention_period = var.backup_retention_period
}
