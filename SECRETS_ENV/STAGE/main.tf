

provider "github" {
    token = "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"
    organization = var.man_org
}

resource "github_actions_secret" "example_secret" {
  count = length(var.name_secrets)
  repository       = "${var.repos}"
  secret_name      = "${element(var.name_secrets,count.index)}"
  plaintext_value  = "${element(var.secrets,count.index)}"

}
