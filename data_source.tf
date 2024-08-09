data "aws_iam_role" "github-iam-role" {
  name = var.githubactions_role
}