# Mantener las direcciones históricas para estados previos a esta organización.

moved {
  from = aws_vpc.vpc_compartida
  to   = module.red.aws_vpc.vpc_compartida
}

moved {
  from = aws_subnet.subred_privada_a
  to   = module.red.aws_subnet.subred_privada_a
}

moved {
  from = aws_subnet.subred_privada_b
  to   = module.red.aws_subnet.subred_privada_b
}

moved {
  from = aws_subnet.subred_publica_a
  to   = module.red.aws_subnet.subred_publica_a
}

moved {
  from = aws_subnet.subred_publica_b
  to   = module.red.aws_subnet.subred_publica_b
}

moved {
  from = aws_internet_gateway.gateway_internet
  to   = module.red.aws_internet_gateway.gateway_internet
}

moved {
  from = aws_eip.ip_publica_nat
  to   = module.red.aws_eip.ip_publica_nat
}

moved {
  from = aws_nat_gateway.nat_publico
  to   = module.red.aws_nat_gateway.nat_publico
}

moved {
  from = aws_eip.ip_publica_nat_b
  to   = module.red.aws_eip.ip_publica_nat_b
}

moved {
  from = aws_nat_gateway.nat_publico_b
  to   = module.red.aws_nat_gateway.nat_publico_b
}

moved {
  from = aws_route_table.rutas_publicas
  to   = module.red.aws_route_table.rutas_publicas
}

moved {
  from = aws_route.salida_publica_internet
  to   = module.red.aws_route.salida_publica_internet
}

moved {
  from = aws_route_table_association.publica_a
  to   = module.red.aws_route_table_association.publica_a
}

moved {
  from = aws_route_table_association.publica_b
  to   = module.red.aws_route_table_association.publica_b
}

moved {
  from = aws_route_table.rutas_privadas_a
  to   = module.red.aws_route_table.rutas_privadas_a
}

moved {
  from = aws_route.salida_privada_a
  to   = module.red.aws_route.salida_privada_a
}

moved {
  from = aws_route_table_association.privada_a
  to   = module.red.aws_route_table_association.privada_a
}

moved {
  from = aws_route_table.rutas_privadas_b
  to   = module.red.aws_route_table.rutas_privadas_b
}

moved {
  from = aws_route.salida_privada_b
  to   = module.red.aws_route.salida_privada_b
}

moved {
  from = aws_route_table_association.privada_b
  to   = module.red.aws_route_table_association.privada_b
}

moved {
  from = aws_vpc_endpoint.s3
  to   = module.red.aws_vpc_endpoint.s3
}

moved {
  from = module.red.aws_vpc.vpc_compartida
  to   = module.red_base.aws_vpc.vpc_compartida
}

moved {
  from = module.red.aws_subnet.subred_privada_a
  to   = module.red_base.aws_subnet.subred_privada_a
}

moved {
  from = module.red.aws_subnet.subred_privada_b
  to   = module.red_base.aws_subnet.subred_privada_b
}

moved {
  from = module.red.aws_subnet.subred_publica_a
  to   = module.red_base.aws_subnet.subred_publica_a
}

moved {
  from = module.red.aws_subnet.subred_publica_b
  to   = module.red_base.aws_subnet.subred_publica_b
}

moved {
  from = module.red.aws_internet_gateway.gateway_internet
  to   = module.salida_internet.aws_internet_gateway.gateway_internet
}

moved {
  from = module.red.aws_eip.ip_publica_nat
  to   = module.salida_internet.aws_eip.ip_publica_nat
}

moved {
  from = module.red.aws_nat_gateway.nat_publico
  to   = module.salida_internet.aws_nat_gateway.nat_publico
}

moved {
  from = module.red.aws_eip.ip_publica_nat_b
  to   = module.salida_internet.aws_eip.ip_publica_nat_b
}

moved {
  from = module.red.aws_nat_gateway.nat_publico_b
  to   = module.salida_internet.aws_nat_gateway.nat_publico_b
}

moved {
  from = module.red.aws_route_table.rutas_publicas
  to   = module.salida_internet.aws_route_table.rutas_publicas
}

moved {
  from = module.red.aws_route.salida_publica_internet
  to   = module.salida_internet.aws_route.salida_publica_internet
}

moved {
  from = module.red.aws_route_table_association.publica_a
  to   = module.salida_internet.aws_route_table_association.publica_a
}

moved {
  from = module.red.aws_route_table_association.publica_b
  to   = module.salida_internet.aws_route_table_association.publica_b
}

moved {
  from = module.red.aws_route_table.rutas_privadas_a
  to   = module.acceso_privado.aws_route_table.rutas_privadas_a
}

moved {
  from = module.red.aws_route.salida_privada_a
  to   = module.acceso_privado.aws_route.salida_privada_a
}

moved {
  from = module.red.aws_route_table_association.privada_a
  to   = module.acceso_privado.aws_route_table_association.privada_a
}

moved {
  from = module.red.aws_route_table.rutas_privadas_b
  to   = module.acceso_privado.aws_route_table.rutas_privadas_b
}

moved {
  from = module.red.aws_route.salida_privada_b
  to   = module.acceso_privado.aws_route.salida_privada_b
}

moved {
  from = module.red.aws_route_table_association.privada_b
  to   = module.acceso_privado.aws_route_table_association.privada_b
}

moved {
  from = module.red.aws_vpc_endpoint.s3
  to   = module.acceso_privado.aws_vpc_endpoint.s3
}
