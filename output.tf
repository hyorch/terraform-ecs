output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.ecs_bridge_alb.alb_dns_name
}