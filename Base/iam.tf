resource "aws_iam_openid_connect_provider" "OIDC_provider" {
  url = var.github_token_url

  client_id_list = [ 
    var.aws_sts_api,
  ]

  thumbprint_list = [ var.var.github_thumbprint ]
}