resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_url.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks_oidc_url.url

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_iam_role" "adding_eks_role" {
  name = var.githubactions-role-name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::298390376199:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:Satyanth/Terraform:*"
                }
            }
        },
        {
          "Effect": "Allow",
          "Principal" : {
              "Federated": aws_iam_openid_connect_provider.eks_oidc_provider.arn
          },
          "Action": "sts:AssumeRoleWithWebIdentity",
          "Condition": {
            "StringEquals": {
                "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub" = "system:${ kubernetes_service_account.svc_account.name }:${ kubernetes_namespace.kube_namespace.name }:aws-node"
          }
        }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
     })
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