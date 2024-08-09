module "base" {
  source = "./Base"
  githubactions-role = data.aws_iam_role.github-iam-role.id
}

module "kube" {
  source = "./Kube"
}