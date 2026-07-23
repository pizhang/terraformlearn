variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "github_owner" {
  type        = string
  description = "GitHub owner or organization for the repository"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name"
}

variable "role_name" {
  type    = string
  default = "github-actions-iam-role"
}

variable "allowed_branches" {
  type        = list(string)
  default     = ["main", "lesson02"]
  description = "Branches allowed to assume this role (used to build the token.actions.githubusercontent.com:sub condition)"
}

variable "allow_tags" {
  type        = bool
  default     = false
  description = "If true, allow tag refs (refs/tags/*) in addition to branches"
}

variable "create_policy" {
  type        = bool
  default     = true
  description = "If true the module creates an IAM policy; otherwise set attached_policy_arn"
}

variable "allowed_actions" {
  type        = list(string)
  default     = ["sts:GetCallerIdentity"]
  description = "List of IAM actions granted to the GitHub Actions role (narrow these to least privilege)"
}

variable "allowed_resources" {
  type        = list(string)
  default     = ["*"]
  description = "Resources the allowed_actions apply to — restrict this to ARNs used by your CI where possible"
}

variable "attached_policy_arn" {
  type        = string
  default     = ""
  description = "If create_policy = false, supply an existing policy ARN to attach to the role"
}
