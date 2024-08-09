module "base" {
  source = "./Base"
  role = data.aws_iam_role.github-iam-role.id
}

module "kube" {
  source = "./Kube"
}