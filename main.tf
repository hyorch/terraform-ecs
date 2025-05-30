# Deploy Task as Modules
# Just one module could be enabled at a time

# Bridge - Port Mapping
# module "ecs_task_bridge" {
#   source = "./modules/ecs_task_bridge"
#   ecs_cluster_name = var.ecs_cluster_name
#   ecs_cluster_id = aws_ecs_cluster.main.id
# }

# Bridge - ALB Dynamic Port Mapping
# module "ecs_task_alb" {
#   source             = "./modules/ecs_task_alb"
#   alb_subnet_ids     = aws_subnet.public[*].id
#   private_subnet_ids = aws_subnet.private[*].id
#   ecs_security_group = aws_security_group.ecs.id
#   vpc_id             = aws_vpc.vpc.id
#   ecs_cluster_id     = aws_ecs_cluster.main.id
#   ecs_instance_role  = aws_iam_role.ecs_instance_role.arn
# }

# Jenkins
module "ecs_bridge_alb" {
  source             = "./modules/ecs_bridge_alb"
  alb_subnet_ids     = aws_subnet.public[*].id
  private_subnet_ids = aws_subnet.private[*].id
  ecs_security_group = aws_security_group.ecs.id
  vpc_id             = aws_vpc.vpc.id
  ecs_cluster_id     = aws_ecs_cluster.main.id
  ecs_instance_role  = aws_iam_role.ecs_instance_role.arn

  container_name   = "jenkins"
  container_port   = 8080
  container_image  = "jenkins/jenkins:lts"
  container_memory = 512
  container_cpu    = 256

}