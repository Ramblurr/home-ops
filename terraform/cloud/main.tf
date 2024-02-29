data "sops_file" "cloudflare_secrets" {
  source_file = "secret.sops.yaml"
}

locals {
  secrets              = yamldecode(data.sops_file.cloudflare_secrets.raw)
  cloudflare_domains   = nonsensitive(local.secrets.cloudflare_domains)
}

provider "cloudflare" {}

module "domains" {
  source              = "./modules/domain"
  for_each            = local.cloudflare_domains
  domain              = each.value.domain
  dav_enabled         = each.value.dav_enabled
  dav_domain          = each.value.dav_domain
  root_record_enabled = each.value.root_record_enabled
  subdomains          = try(each.value.subdomains, {})
}
