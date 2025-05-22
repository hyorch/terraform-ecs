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

