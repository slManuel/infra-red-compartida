resource "aws_subnet" "subred_privada_a" {
  vpc_id                  = aws_vpc.vpc_compartida.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.private_subnet_a_az
  map_public_ip_on_launch = false

  tags = {
    Name = "prueba-devops-subred-privada-a"
  }
}

resource "aws_subnet" "subred_privada_b" {
  vpc_id                  = aws_vpc.vpc_compartida.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.private_subnet_b_az
  map_public_ip_on_launch = false

  tags = {
    Name = "prueba-devops-subred-privada-b"
  }
}

resource "aws_subnet" "subred_publica_a" {
  vpc_id            = aws_vpc.vpc_compartida.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = var.public_subnet_a_az

  # No asignar IP pública automáticamente a los recursos de esta subred.
  map_public_ip_on_launch = false

  tags = {
    Name = "prueba-devops-subred-publica-a"
  }
}

resource "aws_subnet" "subred_publica_b" {
  vpc_id            = aws_vpc.vpc_compartida.id
  cidr_block        = "10.0.102.0/24"
  availability_zone = var.public_subnet_b_az

  # No asignar IP pública automáticamente a los recursos de esta subred.
  map_public_ip_on_launch = false

  tags = {
    Name = "prueba-devops-subred-publica-b"
  }
}
