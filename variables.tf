variable "aws_region" {
  description = "Región del laboratorio; mantener alineada con el presupuesto."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = var.aws_region == "us-east-1"
    error_message = "Este laboratorio se ha presupuestado en us-east-1. Revisar costos y diseño antes de habilitar otra región."
  }
}

variable "aws_account_id" {
  description = "ID de 12 dígitos de la cuenta autorizada para el laboratorio. No es una contraseña."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "El identificador de cuenta debe contener exactamente 12 dígitos."
  }
}

variable "private_subnet_a_az" {
  description = "Zona de disponibilidad de la primera subred privada."
  type        = string
  default     = "us-east-1a"
  nullable    = false

  validation {
    condition     = var.private_subnet_a_az == "us-east-1a"
    error_message = "La primera subred privada debe usar us-east-1a."
  }
}

variable "private_subnet_b_az" {
  description = "Zona de disponibilidad de la segunda subred privada."
  type        = string
  default     = "us-east-1b"
  nullable    = false

  validation {
    condition     = var.private_subnet_b_az == "us-east-1b"
    error_message = "La segunda subred privada debe usar us-east-1b."
  }
}

variable "public_subnet_a_az" {
  description = "Zona de disponibilidad de la primera subred pública."
  type        = string
  default     = "us-east-1a"
  nullable    = false

  validation {
    condition     = var.public_subnet_a_az == "us-east-1a"
    error_message = "La primera subred pública debe usar us-east-1a."
  }
}

variable "public_subnet_b_az" {
  description = "Zona de disponibilidad de la segunda subred pública."
  type        = string
  default     = "us-east-1b"
  nullable    = false

  validation {
    condition     = var.public_subnet_b_az == "us-east-1b"
    error_message = "La segunda subred pública debe usar us-east-1b."
  }
}
