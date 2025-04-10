output "vpc_id" {
  value = aws_vpc.estudos_gateway_routing.id
}

output "vpc_cidr_block" {
  value = aws_vpc.estudos_gateway_routing.cidr_block
}

output "pub_subnet_01" {
  value = aws_subnet.estudos_gateway_routing_pub_1.id
}

output "pub_subnet_02" {
  value = aws_subnet.estudos_gateway_routing_pub_2.id
}

output "pri_subnet_01" {
  value = aws_subnet.estudos_gateway_routing_pri_1.id
}

output "pri_subnet_02" {
  value = aws_subnet.estudos_gateway_routing_pri_2.id
}