resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks-cluster-name
  role_arn = var.githubactions-role-arn
  vpc_config {
    subnet_ids = [var.public_subnet_one_id, var.public_subnet_two_id]
  }
}

resource "kubernetes_service_account" "svc_account" {
  metadata {
    name = var.kube_svc_account
  }
}

resource "kubernetes_namespace" "kube_namespace" {
  metadata {
    annotations = {
      name = "namespace-annotation"
    }

    labels = {
      mylabel = "kube-namespace"
    }
    name = var.kube_namespace
  }
}