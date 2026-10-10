output "nat_gateway_a_id" {
  description = "NAT de us-east-1a."
  value       = aws_nat_gateway.nat_publico.id
}

output "nat_gateway_b_id" {
  description = "NAT de us-east-1b."
  value       = aws_nat_gateway.nat_publico_b.id
}
