terraform {
  backend "remote" {
    hostname     = "app.terraform.io"    # or your HCP hostname
    organization = "<YOUR_ORG>"

    workspaces {
      name = "<YOUR_WORKSPACE>"
    }
  }
}
