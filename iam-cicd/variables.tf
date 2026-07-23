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
  type    = list(string)
  default = ["main", "lesson02"]
}
