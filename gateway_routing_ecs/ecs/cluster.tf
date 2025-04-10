resource "aws_ecs_cluster" "estudos_gateway_routing" {
  name = "estudos-gateway-rounting"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}