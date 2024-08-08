resource "aws_eks_cluster" "eks_cluster" {
  name = var.eks-cluster-name
  role = data.aws_iam_role.github-iam-role.arn

  vpc_config {
    subnet_ids = [module.base.public_subnet_one_id, module.base.public_subnet_two_id]
  }
}