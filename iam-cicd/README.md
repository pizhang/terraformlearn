# Create AWS GitHub Web Identity and IAM role for GitHub Workflow

This module creates AWS IAM resources to allow GitHub Actions to authenticate with AWS using OpenID Connect (OIDC).

## Resources created

- `aws_iam_openid_connect_provider`
- `aws_iam_role`
- `aws_iam_policy`
- `aws_iam_role_policy_attachment`

## Usage

```hcl
module "github_cicd" {
  source = "./iam-cicd"

  region          = "ap-southeast-2"
  github_owner    = "<GITHUB_OWNER>"
  github_repo     = "<GITHUB_REPO>"
  role_name       = "github-actions-iam-role"
  allowed_branches = ["main", "lesson02"]
}
```

## Notes

- Replace `github_owner` and `github_repo` with your GitHub org/user and repo name.
- The role trust policy restricts access to GitHub Actions runs from `main` and `lesson02` branches.
- Update the IAM policy to grant least privilege for your Terraform deployment needs.
