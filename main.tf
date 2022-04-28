resource "aws_db_instance" "posgress" {
  engine = "postgres"
}
resource "aws_security_group" "sg-https" {
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
}
resource "aws_rds_cluster" "rds-cluster" {
  backup_retention_period = 0
  deletion_protection     = true
}
