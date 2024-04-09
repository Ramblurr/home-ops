data "sops_file" "cloudflare_secrets" {
  source_file = "../secrets.sops.yaml"
}

data "sops_file" "module_secrets" {
  source_file = "./secrets.sops.yaml"
}

locals {
  secrets              = yamldecode(data.sops_file.cloudflare_secrets.raw)
  module_secrets       = yamldecode(data.sops_file.module_secrets.raw)
  cloudflare_domains   = nonsensitive(local.module_secrets.cloudflare_domains)
  onepassword_vault_id = local.secrets.onepassword_vault_id
  vault                = local.onepassword_vault_id
}

provider "cloudflare" {}

provider "onepassword" {
  url = "https://op.socozy.casa"
  # token specified via env var
}

module "domains" {
  source              = "./modules/domain"
  for_each            = local.cloudflare_domains
  domain              = each.value.domain
  dav_enabled         = each.value.dav_enabled
  dav_domain          = each.value.dav_domain
  root_record_enabled = each.value.root_record_enabled
  account_id          = local.secrets.cloudflare_account_id
  cnames              = try(each.value.cnames, {})
  tunnels             = try(each.value.tunnels, {})
  vault               = local.vault
}
