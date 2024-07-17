
data "aws_secretsmanager_secret" "rds_password" {
  name = "rds_masters_passwords"
}

data "aws_secretsmanager_secret_version" "rds_password_version" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}
