
resource "aws_ecs_cluster" "app" {
  name = "java-app-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "java-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "java-microservice"
    image = var.ecr_image_url
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
  }])
}

resource "aws_ecs_service" "app" {
  name            = "java-app-service"
  cluster         = aws_ecs_cluster.app.id
  launch_type     = "FARGATE"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.app.arn

  network_configuration {
    //subnets         = data.aws_subnets.private.ids
    subnets           = var.private_subnets_ids
    security_groups = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "java-microservice"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.http]
}
