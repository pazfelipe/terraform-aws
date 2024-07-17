resource "aws_secretsmanager_secret" "rds" {
  name        = "rds_masters_passwords"
  description = "RDS master passwords for databases"
  tags = {
    Terraform = true
  }
}