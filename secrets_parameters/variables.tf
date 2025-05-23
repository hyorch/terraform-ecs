variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-south-2"

}

variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "HyorchAdmin"

}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  default     = "db1234"

}

variable "kafka_password" {
  description = "Contraseña de Kafka"
  type        = string
  default     = "kafka1234"

}