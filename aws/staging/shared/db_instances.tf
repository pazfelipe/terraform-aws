resource "aws_kms_key" "this" {
  description = "RDS encryption key"
}

resource "aws_db_parameter_group" "this" {
  name   = "custom-mysql"
  family = "mysql8.0"

  parameter {
    name  = "wait_timeout"
    value = "18000"
  }
  parameter {
    name  = "interactive_timeout"
    value = "18000"
  }
  parameter {
    name  = "max_connections"
    value = "1000"
  }
}

resource "aws_db_instance" "this" {
  allocated_storage     = 10
  max_allocated_storage = 1000
  publicly_accessible   = true
  db_name               = "db_name"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.medium"
  username              = "user_db"
  password              = jsondecode(data.aws_secretsmanager_secret_version.rds_password_version.secret_string)["influencers"]
  parameter_group_name  = aws_db_parameter_group.this.name
  identifier            = "db_name_identifier"
  tags = {
    Environment = "staging",
    Managed     = "Terraform"
  }
}
