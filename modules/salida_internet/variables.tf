variable "vpc_id" {
  description = "VPC compartida."
  type        = string
  nullable    = false
}

variable "public_subnet_a_id" {
  description = "Subred pública de us-east-1a."
  type        = string
  nullable    = false
}

variable "public_subnet_b_id" {
  description = "Subred pública de us-east-1b."
  type        = string
  nullable    = false
}
