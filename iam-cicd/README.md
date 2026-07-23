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

### AWS login methods

Before running Terraform, authenticate to AWS using one of these methods:

- AWS CLI with long-lived credentials
  - Run `aws configure` and enter `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION`.
- Environment variables (CI or local)
  - Export `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and optionally `AWS_SESSION_TOKEN` and `AWS_REGION`.
- AWS SSO
  - Configure a profile for SSO in `~/.aws/config` and run `aws sso login --profile <profile>`.
  - Use the profile in Terraform by setting `AWS_PROFILE` or provider `profile` argument.
- Assume role via an existing profile
  - Use an existing named profile that assumes a role (configured in `~/.aws/config`) and set `AWS_PROFILE=<profile>`.

Choose the method that best fits your security posture. For automation in GitHub Actions, prefer short-lived credentials obtained via OIDC and the role created by this module.

### Terraform Cloud / HCP (remote) backend login

This module supports storing state in Terraform Cloud / HCP workspaces using the `remote` backend. Authenticate to the remote service before running `terraform init`:

- Interactive login:
  - Run `terraform login` which will prompt and store an API token for the hostname (e.g. `app.terraform.io`).
- Environment token (non-interactive / CI):
  - Set `TF_TOKEN_app_terraform_io` (for Terraform Cloud/HCP on `app.terraform.io`) with a user or team token that has permissions to the organization and workspace.

Notes:
- If your organization uses a custom hostname for HCP, replace `app.terraform.io` with your hostname and set the corresponding environment variable `TF_TOKEN_<hostname_sanitized>` as documented by Terraform Cloud.
- You can provide backend config values interactively or via `-backend-config` flags when running `terraform init` (useful for CI).

### Terraform commands (recommended flow)

From the `iam-cicd` directory:

1. Initialize (and authenticate to the remote backend when prompted):
   - Interactive remote login: `terraform login` (if using Terraform Cloud/HCP)
   - Then: `terraform init` or to set backend config non-interactively:
     `terraform init -backend-config="organization=<ORG>" -backend-config="workspaces.name=<WORKSPACE>"`

2. Validate and format:
   - `terraform fmt -recursive`
   - `terraform validate`

3. Preview changes:
   - `terraform plan -var='github_owner=<GITHUB_OWNER>' -var='github_repo=<GITHUB_REPO>'`

4. Apply changes (review plan output first):
   - `terraform apply -var='github_owner=<GITHUB_OWNER>' -var='github_repo=<GITHUB_REPO>'`

5. (Optional) If you use different workspaces for environments, switch or create workspaces via the Terraform Cloud UI or CLI and re-run `terraform init`/`terraform apply`.

### Example backend configuration (iam-cicd/backend.tf)

Below is an example `backend.tf` that configures the Terraform `remote` backend for Terraform Cloud / HCP. Replace the placeholders with your organization and workspace names.

```hcl
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"    # or your HCP hostname
    organization = "<YOUR_ORG>"

    workspaces {
      name = "<YOUR_WORKSPACE>"
    }
  }
}
```

If you prefer not to commit `backend.tf` with organization/workspace hard-coded, run `terraform init -backend-config="organization=<YOUR_ORG>" -backend-config="workspaces.name=<YOUR_WORKSPACE>"` and keep backend settings out of source control.

## Notes

- Replace `github_owner` and `github_repo` with your GitHub org/user and repo name.
- The role trust policy restricts access to GitHub Actions runs from the configured branches (and tags when `allow_tags = true`).
- Update the IAM policy to grant least privilege for your Terraform deployment needs.
- Thumbprint: the module is using the common GitHub Actions OIDC thumbprint (`6938fd...`). Keep this up to date if GitHub changes their CA chain.
- Avoid creating a second OIDC provider for the same URL/issuer in the same AWS account; reuse an existing provider if present.
- Test in a non-production account first: `terraform init && terraform plan`.
