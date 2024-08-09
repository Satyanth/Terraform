variable "eks-cluster-name" {
  description = "Name of eks cluster"
  type        = string
  default     = "dev-eks-cluster"
}

variable "public_subnet_one_id" {
  description = "subnet id for first subnet"
  type        = string
}

variable "public_subnet_two_id" {
  description = "subnet id for second subnet"
  type        = string
}
