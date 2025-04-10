resource "aws_lb" "estudos_gateway_routing" {
  name               = "estudos-gateway-rounting"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_pub_id]
  subnets            = [var.subnet_id_pub_1, var.subnet_id_pub_2]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "estudos_gateway_routing_app01" {
  name     = "estudos-gateway-rounting-app-01"
  port     = 3000 # dont matter
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/app-01/health"
  }
}

resource "aws_lb_target_group" "estudos_gateway_routing_app02" {
  name        = "estudos-gateway-rounting-app-02"
  port        = 3000 # dont matter
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/app-02/health"
  }
}


resource "aws_lb_listener" "estudos_gateway_routing" {
  load_balancer_arn = aws_lb.estudos_gateway_routing.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.estudos_gateway_routing_app01.id
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "estudos_gateway_routing_app01" {
  listener_arn = aws_lb_listener.estudos_gateway_routing.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.estudos_gateway_routing_app01.arn
  }
  condition {
    path_pattern {
      values = ["/app-01*"]
    }
  }
}

resource "aws_lb_listener_rule" "estudos_gateway_routing_app02" {
  listener_arn = aws_lb_listener.estudos_gateway_routing.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.estudos_gateway_routing_app02.arn
  }
  condition {
    path_pattern {
      values = ["/app-02*"]
    }
  }
}
