resource "aws_iam_openid_connect_provider" "OIDC_provider" {
  url = var.github_token_url

  client_id_list = [
    var.aws_sts_api,
  ]

  thumbprint_list = [var.github_thumbprint]
}

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