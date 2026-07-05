locals {
    # Common tags to be assigned to all resources
    common_tags = {
        Environment = var.environment
        Project     = var.project
        Owner       = var.owner
        Terraform   = "true"
    }
}