resource "aws_internet_gateway" "gateway_internet" {
  vpc_id = var.vpc_id

  tags = {
    Name = "prueba-devops-internet-gateway"
  }
}

resource "aws_eip" "ip_publica_nat" {
  domain = "vpc"

  tags = {
    Name = "prueba-devops-ip-publica-nat"
  }
}

resource "aws_nat_gateway" "nat_publico" {
  availability_mode = "zonal"
  connectivity_type = "public"
  allocation_id     = aws_eip.ip_publica_nat.id
  subnet_id         = var.public_subnet_a_id

  tags = {
    Name = "prueba-devops-nat-publico"
  }

  depends_on = [
    aws_internet_gateway.gateway_internet,
    aws_route.salida_publica_internet,
    aws_route_table_association.publica_a,
  ]
}

resource "aws_eip" "ip_publica_nat_b" {
  domain = "vpc"

  tags = {
    Name = "prueba-devops-ip-publica-nat-b"
  }
}

resource "aws_nat_gateway" "nat_publico_b" {
  availability_mode = "zonal"
  connectivity_type = "public"
  allocation_id     = aws_eip.ip_publica_nat_b.id
  subnet_id         = var.public_subnet_b_id

  tags = {
    Name = "prueba-devops-nat-publico-b"
  }

  depends_on = [
    aws_internet_gateway.gateway_internet,
    aws_route.salida_publica_internet,
    aws_route_table_association.publica_b,
  ]
}
