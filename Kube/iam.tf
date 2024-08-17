resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_url.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks_oidc_url.url

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_iam_role_policy_attachment" "aws_node" {
  role       = var.githubactions-role-name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = var.githubactions-role-name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  role       = var.githubactions-role-name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}