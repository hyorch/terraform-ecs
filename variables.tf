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

variable "vpc_name" {
  description = "Nombre del VPC"
  type        = string
  default     = "zaragoza"
}

variable "vpc_cidr" {
  description = "CIDR block para el VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "ecs_cluster_name" {
  description = "Nombre del ECS Cluster"
  type        = string
  default     = "zaragoza-ecs"
}

variable "ecs_instance_type" {
  description = "Tipo de instancia para los nodos ECS"
  type        = string
  default     = "t3.micro"
}