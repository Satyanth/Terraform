variable "public_CIDR" {
  description = "CIDR Block for public subnet"
  type        = string
  default     = "10.10.2.0/24"
}

variable "private_CIDR" {
  description = "CIDR Block for private subnet"
  type        = string
  default     = "10.10.3.0/24"
}