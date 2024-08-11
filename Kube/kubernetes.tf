resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks-cluster-name
  role_arn = var.githubactions-role-arn
  vpc_config {
    subnet_ids = [var.public_subnet_one_id, var.public_subnet_two_id]
  }

  depends_on = [ aws_iam_role.eks_role ]
}