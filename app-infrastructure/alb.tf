
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

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
