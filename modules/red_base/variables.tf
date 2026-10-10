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
