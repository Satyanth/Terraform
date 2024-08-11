resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.thumbprint
  url             = var.oidc_url
}

resource "aws_iam_role" "eks_role" {
  assume_role_policy = templatefile("${path.module}/templates/eks_role_policy.json", { OIDC_ARN = aws_iam_openid_connect_provider.eks_oidc_provider.arn, OIDC_URL = replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", ""), NAMESPACE = "kube-system", SA_NAME = "aws-node" })
  name               = "eks_role"
}

resource "aws_iam_role_policy_attachment" "aws_node" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}