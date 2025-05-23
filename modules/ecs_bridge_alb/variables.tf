variable "ecs_cluster_id" {
  description = "ID del ECS Cluster"
  type        = string
}

variable "alb_subnet_ids" {
  description = "Subnets for ALB"
  type        = list(string)
}

variable "ecs_security_group" {
  description = "Security group for ECS"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string

}

variable "private_subnet_ids" {
  description = "Private subnets for ECS"
  type        = list(string)
}

variable "ecs_instance_role" {
  description = "ECS Instance Role"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "container_image" {
  description = "Container image"
  type        = string
}
variable "container_memory" {
  description = "Container memory"
  type        = number
}
variable "container_cpu" {
  description = "Container CPU"
  type        = number
}
