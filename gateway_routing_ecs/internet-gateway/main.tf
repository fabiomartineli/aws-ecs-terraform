resource "aws_internet_gateway" "estudos_gateway_routing" {
  vpc_id = var.vpc_id
}