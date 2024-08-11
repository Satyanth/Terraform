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

variable "githubactions-role-arn" {
  type        = string
  description = "Github actions role arn"
}

variable "githubactions-role-name" {
  type        = string
  description = "Github actions role"
}

variable "eks_oidc_policy" {
  type        = string
  description = "Name for eks policy"
  default     = "eks-oidc-policy"
}

variable "githubactions-role-id" {
  type        = string
  description = "Github actions role id"
}

