resource "aws_route_table" "rutas_publicas" {
  vpc_id = var.vpc_id

  tags = {
    Name = "prueba-devops-rutas-publicas"
  }
}

resource "aws_route" "salida_publica_internet" {
  route_table_id         = aws_route_table.rutas_publicas.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway_internet.id
}

resource "aws_route_table_association" "publica_a" {
  subnet_id      = var.public_subnet_a_id
  route_table_id = aws_route_table.rutas_publicas.id
}

resource "aws_route_table_association" "publica_b" {
  subnet_id      = var.public_subnet_b_id
  route_table_id = aws_route_table.rutas_publicas.id
}
