## BRIDGED MODE - PORT MAPPING ECS TASK

#Define an ecs task to deploy a simple web server with nginx
resource "aws_ecs_task_definition" "web_server" {
  family                   = "bridge-static_mapping-web-server"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"


  container_definitions = jsonencode([
    {
      name      = "web-server"
      image     = "nginx:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      healthCheck = {
        "command" : [
          "CMD-SHELL",
          "curl -f http://localhost/ || exit 1"
        ],
        "interval" : 30,
        "timeout" : 5,
        "retries" : 3,
        "startPeriod" : 30
      }


    }
  ])

  tags = {
    Name = "${var.ecs_cluster_name}-web-server"
  }
}

resource "aws_ecs_service" "web_server" {
  name            = "${var.ecs_cluster_name}-web-server"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.web_server.arn
  desired_count   = 1
  launch_type     = "EC2"

  tags = {
    Name = "${var.ecs_cluster_name}-web-server"
  }
}