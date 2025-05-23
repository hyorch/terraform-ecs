# Bridge Mode - ALB Dynamic Port Mapping
# Generic container
resource "aws_ecs_task_definition" "web_server" {
  family                   = "bridge-alb-${var.container_name}"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
      name   = var.container_name
      image  = var.container_image
      cpu    = var.container_cpu
      memory = var.container_memory

      essential = true
          
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = 0
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
}

resource "aws_lb" "ecs_lb" {
  name               = "ecs-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ecs_security_group]
  subnets            = var.alb_subnet_ids
}

resource "aws_lb_target_group" "web_server" {
  name        = "web-server-tg"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}

resource "aws_lb_listener" "web_server" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server.arn
  }
}


resource "aws_ecs_service" "web-server" {
  name            = "web_server_service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.web_server.arn
  desired_count   = 1
  launch_type     = "EC2"

  health_check_grace_period_seconds = 20

  #arn:aws:iam::110439129663:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS
  iam_role = "/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"

  load_balancer {
    target_group_arn = aws_lb_target_group.web_server.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}

# # IAM Role for ECS Task Execution Role
resource "aws_iam_role" "task_execution_role" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json

  tags = {
    Name = "ecsTaskExecutionRole"
  }
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}



# Default AWS ECS Execution Role (ECR and logging)
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Create Policy to access SSM and Secrets Manager
resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecsTaskPolicy-SSM_SecretsManager"
  description = "ECS Task Policy to access SSM and Secrets Manager"
  policy      = data.aws_iam_policy_document.ecs_task_policy.json
}
resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
data "aws_iam_policy_document" "ecs_task_policy" {
  statement {
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      # must be reduce to the specific resources      
      # "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.environment}/db_password",  
      "*"
    ]
  }
}