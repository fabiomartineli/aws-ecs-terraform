resource "aws_eip" "elastic_ip_1" {
    domain = "vpc"
}

resource "aws_nat_gateway" "estudos_gateway_routing_subnet_1" {
  subnet_id     = var.subnet_1
  allocation_id = aws_eip.elastic_ip_1.id
}

# resource "aws_nat_gateway" "estudos_gateway_routing_subnet_2" {
#   subnet_id     = var.subnet_2
#   allocation_id = aws_eip.elastic_ip_1.id
# }
