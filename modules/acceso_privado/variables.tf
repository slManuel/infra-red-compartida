variable "aws_region" {
  description = "Región del endpoint S3."
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = "VPC compartida."
  type        = string
  nullable    = false
}

variable "private_subnet_a_id" {
  description = "Subred privada de us-east-1a."
  type        = string
  nullable    = false
}

variable "private_subnet_b_id" {
  description = "Subred privada de us-east-1b."
  type        = string
  nullable    = false
}

variable "nat_gateway_a_id" {
  description = "NAT público de us-east-1a."
  type        = string
  nullable    = false
}

variable "nat_gateway_b_id" {
  description = "NAT público de us-east-1b."
  type        = string
  nullable    = false
}
