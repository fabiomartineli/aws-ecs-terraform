resource "aws_ecs_service" "estudos_gateway_routing_app_01" {
  name            = "app-01"
  cluster         = aws_ecs_cluster.estudos_gateway_routing.id
  task_definition = aws_ecs_task_definition.estudos_gateway_routing_app_01.arn
  desired_count   = 1 
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.subnet_id_pri_1, var.subnet_id_pri_2]
    security_groups  = [var.security_group_pri_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.estudos_gateway_routing_app01.arn
    container_name   = "app-01"
    container_port   = 3000
  }
}

resource "aws_ecs_service" "estudos_gateway_routing_app_02" {
  name            = "app-02"
  cluster         = aws_ecs_cluster.estudos_gateway_routing.id
  task_definition = aws_ecs_task_definition.estudos_gateway_routing_app_02.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.subnet_id_pri_1, var.subnet_id_pri_2]
    security_groups  = [var.security_group_pri_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.estudos_gateway_routing_app02.arn
    container_name   = "app-02"
    container_port   = 3000
  }
}