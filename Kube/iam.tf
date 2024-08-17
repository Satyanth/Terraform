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