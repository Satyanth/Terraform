resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_url.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks_oidc_url.url
}

resource "aws_iam_role" "eks_role" {
  assume_role_policy = templatefile("${path.module}/templates/eks_role_policy.json", { OIDC_ARN = aws_iam_openid_connect_provider.eks_oidc_provider.arn, OIDC_URL = replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", ""), NAMESPACE = "kube-system", SA_NAME = "aws-node" })
  name               = "eks_role"

  depends_on = [aws_iam_openid_connect_provider.eks_oidc_provider]
}

resource "aws_iam_role_policy_attachment" "aws_node" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  depends_on = [aws_iam_role.eks_role]
}