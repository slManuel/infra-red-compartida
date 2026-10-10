output "private_subnet_ids" {
  description = "Identificadores de las dos subredes privadas de la red compartida."

  value = [
    aws_subnet.subred_privada_a.id,
    aws_subnet.subred_privada_b.id,
  ]
}

output "vpc_id" {
  description = "Identificador de la VPC compartida."
  value       = aws_vpc.vpc_compartida.id
}

output "private_subnet_ids_by_az" {
  description = "Identificadores de las subredes privadas por zona."
  value = {
    (var.private_subnet_a_az) = aws_subnet.subred_privada_a.id
    (var.private_subnet_b_az) = aws_subnet.subred_privada_b.id
  }
}

output "private_subnet_a_id" {
  description = "Primera subred privada."
  value       = aws_subnet.subred_privada_a.id
}

output "private_subnet_b_id" {
  description = "Segunda subred privada."
  value       = aws_subnet.subred_privada_b.id
}

output "public_subnet_a_id" {
  description = "Primera subred pública."
  value       = aws_subnet.subred_publica_a.id
}

output "public_subnet_b_id" {
  description = "Segunda subred pública."
  value       = aws_subnet.subred_publica_b.id
}
