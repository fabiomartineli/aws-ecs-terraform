resource "aws_route_table" "estudos_gateway_routing_pub" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igtw_id
  }
}

resource "aws_route_table" "estudos_gateway_routing_pri_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id_1
  }
}

# resource "aws_route_table" "estudos_gateway_routing_pri_2" {
#   vpc_id = var.vpc_id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = var.nat_id_1
#   }
# }

# resource "aws_route" "estudos_gateway_routing_pri_sub_1" {
#   route_table_id         = aws_route_table.estudos_gateway_routing_pri.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = var.nat_id_1
# }

# resource "aws_route" "estudos_gateway_routing_pri_sub_2" {
#   route_table_id         = aws_route_table.estudos_gateway_routing_pri.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = var.nat_id_2
# }

resource "aws_route_table_association" "estudos_gateway_routing_pub_1" {
  subnet_id      = var.subnet_id_pub_1
  route_table_id = aws_route_table.estudos_gateway_routing_pub.id
}

resource "aws_route_table_association" "estudos_gateway_routing_pub_2" {
  subnet_id      = var.subnet_id_pub_2
  route_table_id = aws_route_table.estudos_gateway_routing_pub.id
}

resource "aws_route_table_association" "estudos_gateway_routing_pri_1" {
  subnet_id      = var.subnet_id_pri_1
  route_table_id = aws_route_table.estudos_gateway_routing_pri_1.id
}

resource "aws_route_table_association" "estudos_gateway_routing_pri_2" {
  subnet_id      = var.subnet_id_pri_2
  route_table_id = aws_route_table.estudos_gateway_routing_pri_1.id
}
