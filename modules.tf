module "base" {
  source             = "./Base"
  githubactions-role = data.aws_iam_role.github-iam-role.id
}

module "kube" {
  source               = "./Kube"
  public_subnet_one_id = module.base.public_subnet_one_id
  public_subnet_two_id = module.base.public_subnet_two_id
}