resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.rutas_privadas_a.id,
    aws_route_table.rutas_privadas_b.id,
  ]

  tags = {
    Name = "prueba-devops-endpoint-s3"
  }
}
