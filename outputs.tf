output "private_subnet_ids" {
  description = "Identificadores de las dos subredes privadas de la red compartida."
  value       = module.red_base.private_subnet_ids
}

output "vpc_id" {
  description = "Identificador de la VPC compartida."
  value       = module.red_base.vpc_id
}

output "private_subnet_ids_by_az" {
  description = "Identificadores de las subredes privadas por zona."
  value       = module.red_base.private_subnet_ids_by_az
}
