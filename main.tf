

provider "github" {
    token = "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"
    organization = var.man_org
}

resource "null_resource" "name" {
  provisioner "local-exec" {
    command = "env.sh"
    interpreter = ["bash"]
  }
}



# Add a user to the organization
resource "github_membership" "member" {
  count = length(var.list_admins)
  username = element(var.list_admins, count.index)
  role     = "admin"
  depends_on = [null_resource.name]
}

#Add a repository
resource "github_repository" "repository" {
  count = length(var.main_repos)
  name        = "${var.man_org}-${element(var.main_repos,count.index)}"
  visibility = "private"
  allow_merge_commit = true
  auto_init          = true
  depends_on = [null_resource.name]
}

resource "github_actions_secret" "example_secret" {
  count = length(var.name_secrets)
  repository       = "rombabomba-frontend"
  secret_name      = "${element(var.name_secrets,count.index)}"
  plaintext_value  = "${element(var.secrets,count.index)}"
  depends_on = [null_resource.name]
}


data "github_repositories" "example" {
  query = "org:${var.man_org}"
}

output "data_github_repos" {
  value = "${data.github_repositories.example.names}"
}
