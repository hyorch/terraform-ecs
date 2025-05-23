data "aws_ssm_parameter" "environment" {
  name = "environment"
}

data "aws_ssm_parameter" "db_password" {
  name            = "db_password"
  with_decryption = true
}

data "aws_secretsmanager_secret" "kafka_password" {
  name = "kfk_password"
}
data "aws_secretsmanager_secret_version" "kafka_password" {
  secret_id = data.aws_secretsmanager_secret.kafka_password.id
}
