# I have an IAM role associated with HCP Terraform cloud workspace.
# To use this role to create IAM role is too risky, 
# so I will use a different IAM role to create the IAM role for GitHub Actions.

# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"    # or your HCP hostname
#     organization = "pizhang" # or your HCP organization name

#     workspaces {
#       name = "associate004" # or your HCP workspace name
#     }
#   }
# }
