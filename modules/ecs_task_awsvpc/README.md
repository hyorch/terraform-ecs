# ECS Service AWSVPC network Load Balancing

For services with tasks using the awsvpc network mode, when you create a target group for your service, you must choose ip as the target type, not instance. This is because tasks that use the awsvpc network mode are associated with an elastic network interface, not an Amazon EC2 instance.