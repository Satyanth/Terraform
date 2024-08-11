# resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.eks_oidc_url.certificates[0].sha1_fingerprint]
#   url             = data.tls_certificate.eks_oidc_url.url
# }

resource "aws_iam_role" "eks_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
  name               = "eks_role"
}

resource "aws_iam_role_policy_attachment" "aws_node" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}