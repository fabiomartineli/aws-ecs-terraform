resource "aws_vpc" "estudos_gateway_routing" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "estudos_gateway_routing_pub_1" {
  vpc_id     = aws_vpc.estudos_gateway_routing.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "estudos_gateway_routing_pub_2" {
  vpc_id     = aws_vpc.estudos_gateway_routing.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_subnet" "estudos_gateway_routing_pri_1" {
  vpc_id     = aws_vpc.estudos_gateway_routing.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "estudos_gateway_routing_pri_2" {
  vpc_id     = aws_vpc.estudos_gateway_routing.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2b"
}