# Added manually as they are needed as first step to connect to aws.
# resource "aws_iam_openid_connect_provider" "OIDC_provider" {
#   url = var.github_token_url

#   client_id_list = [
#     var.aws_sts_api,
#   ]

#   thumbprint_list = [var.github_thumbprint]
# }

# resource "aws_iam_role" "githubactions_role" {
#   name = "github-actions-role"

#   assume_role_policy = jsondecode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = {
#         Federated = aws_iam_openid_connect_provider.OIDC_provider.arn
#       },
#       Action = "sts:AssumeRoleWithWebIdentity",
#       Condition = {
#         StringEquals = {
#           "token.actions.githubusercontent.com:sub" : "repo:Satyanth/Terraform:ref:refs/heads/main"
#         }
#       }
#     }]
#   })
# }


resource "aws_iam_role_policy" "deploymentresources-policy" {
  name = var.deploymentresource-policy
  role = var.githubactions-role

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DeleteRouteTable",
          "ec2:AssociateRouteTable",
          "ec2:DisassociateRouteTable",
          "ec2:DeleteSubnet",
          "ec2:ModifySubnetAttribute",
          "ec2:Describe*",
          "ec2:Create*",
          "ec2:AttachInternetGateway",
          "ec2:ModifyVpcAttribute"
        ]
        Resource = "*"
      }
    ]
  })
}
