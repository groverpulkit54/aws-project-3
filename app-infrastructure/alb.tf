
resource "aws_lb" "app" {
  name               = "java-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  //subnets            = data.aws_subnets.public.ids
  subnets            = var.public_subnets_ids
}

resource "aws_lb_target_group" "ecs_tg" {
  name     = "ecs-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
  target_type = "ip"


  health_check {
    path     = "/hello"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group" "ecs_tg_2" {
  name         = "ecs-tg-2"
  port         = 8080
  protocol     = "HTTP"
  vpc_id       = data.aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path     = "/hi"
    protocol = "HTTP"
    port     = 8080
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_listener_rule" "user_service_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_2.arn
  }

  condition {
    path_pattern {
      values = ["/hi*"]
    }
  }
}

