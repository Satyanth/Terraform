module "base" {
  source = "./Base"
  role = data.aws_iam_role.github-iam-role.name
}

module "kube" {
  source = "./Kube"
}