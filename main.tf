module "red_base" {
  source              = "./modules/red_base"
  providers           = { aws = aws }
  private_subnet_a_az = var.private_subnet_a_az
  private_subnet_b_az = var.private_subnet_b_az
  public_subnet_a_az  = var.public_subnet_a_az
  public_subnet_b_az  = var.public_subnet_b_az
}

module "salida_internet" {
  source             = "./modules/salida_internet"
  providers          = { aws = aws }
  vpc_id             = module.red_base.vpc_id
  public_subnet_a_id = module.red_base.public_subnet_a_id
  public_subnet_b_id = module.red_base.public_subnet_b_id
}

module "acceso_privado" {
  source              = "./modules/acceso_privado"
  providers           = { aws = aws }
  aws_region          = var.aws_region
  vpc_id              = module.red_base.vpc_id
  private_subnet_a_id = module.red_base.private_subnet_a_id
  private_subnet_b_id = module.red_base.private_subnet_b_id
  nat_gateway_a_id    = module.salida_internet.nat_gateway_a_id
  nat_gateway_b_id    = module.salida_internet.nat_gateway_b_id
}
