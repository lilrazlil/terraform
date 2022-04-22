
terraform {
  required_version = ">= 0.14"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0.0"
  }
}
}