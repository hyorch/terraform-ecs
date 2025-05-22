resource "aws_ssm_parameter" "environment" {
  name  = "environment"
  type  = "String"
  value = var.environment

  overwrite = true

  tags = {
    Name = "environment"
  }
}

resource "aws_ssm_parameter" "db_password" {
  name  = "db_password"
  type  = "SecureString"
  value = var.db_password

  tags = {
    Name = "db_password"
  }
}
