
resource "aws_secretsmanager_secret" "kafka_password" {
  name        = "kfk_password"
  description = "Database password"

}

resource "aws_secretsmanager_secret_version" "kafka_password" {
  secret_id     = aws_secretsmanager_secret.kafka_password.id
  secret_string = var.kafka_password
}

