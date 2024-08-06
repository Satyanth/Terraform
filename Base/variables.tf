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

variable "github_token_url" {
  description = "Url of the github token thumprint"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "aws_sts_api" {
  description = "AWS service token"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "github_thumbprint" {
  description = "Github thumbprint"
  type        = string
  default     = "74F3A68F16524F15424927704C9506F55A9316BD"
}

variable "deploymentresource-policy" {
  description = "Name for deployment resource policy"
  type = string
  default = "deploymentresources-policy"
}

variable "githubactions_role" {
  description = "GitHub actions role"
  type        = string
  default     = "github-actions-role"
}

variable "githubactionsrole_policy" {
  description = "Policy attached to Github actions role"
  type        = string
  default     = "arn:aws:iam::298390376199:policy/github_iam"
}