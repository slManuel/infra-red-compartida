resource "aws_route_table" "rutas_privadas_a" {
  vpc_id = var.vpc_id

  tags = {
    Name = "prueba-devops-rutas-privadas-a"
  }
}

resource "aws_route" "salida_privada_a" {
  route_table_id         = aws_route_table.rutas_privadas_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_a_id
}

resource "aws_route_table_association" "privada_a" {
  subnet_id      = var.private_subnet_a_id
  route_table_id = aws_route_table.rutas_privadas_a.id
}

resource "aws_route_table" "rutas_privadas_b" {
  vpc_id = var.vpc_id

  tags = {
    Name = "prueba-devops-rutas-privadas-b"
  }
}

resource "aws_route" "salida_privada_b" {
  route_table_id         = aws_route_table.rutas_privadas_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_b_id
}

resource "aws_route_table_association" "privada_b" {
  subnet_id      = var.private_subnet_b_id
  route_table_id = aws_route_table.rutas_privadas_b.id
}
