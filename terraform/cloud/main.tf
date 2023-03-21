data "sops_file" "cloudflare_secrets" {
  source_file = "secret.sops.yaml"
}

locals {
  secrets              = yamldecode(data.sops_file.cloudflare_secrets.raw)
  cloudflare_api_token = local.secrets.cloudflare_api_token
  cloudflare_domains   = nonsensitive(local.secrets.cloudflare_domains)
}

provider "cloudflare" {
  api_token = local.cloudflare_api_token
}

module "domains" {
  source              = "./modules/domain"
  for_each            = local.cloudflare_domains
  domain              = each.value.domain
  root_record_enabled = each.value.root_record_enabled
  subdomains          = try(each.value.subdomains, {})
}
