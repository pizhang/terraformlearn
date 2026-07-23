locals {
  github_subjects = concat(
    [for branch in var.allowed_branches : "repo:${var.github_owner}/${var.github_repo}:ref:refs/heads/${branch}"],
    var.allow_tags ? ["repo:${var.github_owner}/${var.github_repo}:ref:refs/tags/*"] : []
  )
}

resource "aws_iam_openid_connect_provider" "github" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  url             = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = local.github_subjects
          }
        }
      }
    ]
  })
}

# Create a scoped IAM policy. By default this policy is intentionally minimal (sts:GetCallerIdentity).
# Update `var.allowed_actions` and `var.allowed_resources` to grant the exact permissions your CI needs.
resource "aws_iam_policy" "github_actions_policy" {
  count       = var.create_policy ? 1 : 0
  name        = "${var.role_name}-policy"
  description = "Permissions for GitHub Actions to operate in AWS (scoped via variables)"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action   = var.allowed_actions
        Resource = var.allowed_resources
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_attach" {
  role       = aws_iam_role.github_actions.name
  policy_arn = var.create_policy ? aws_iam_policy.github_actions_policy[0].arn : var.attached_policy_arn
}
