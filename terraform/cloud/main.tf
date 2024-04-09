data "sops_file" "cloudflare_secrets" {
  source_file = "../secret.sops.yaml"
}

locals {
  secrets            = yamldecode(data.sops_file.cloudflare_secrets.raw)
  cloudflare_domains = nonsensitive(local.secrets.cloudflare_domains)
  cloudflare_tunnels = local.secrets.cloudflare_tunnels
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

resource "random_id" "cloudflare_tunnel_secret" {
  for_each    = local.cloudflare_tunnels
  byte_length = 35
}

resource "cloudflare_tunnel" "tunnel" {
  for_each   = local.cloudflare_tunnels
  account_id = local.secrets.cloudflare_account_id
  name       = each.key
  secret     = random_id.cloudflare_tunnel_secret[each.key].b64_std
  config_src = "local"
}

resource "cloudflare_record" "tunnel" {
  for_each = local.cloudflare_tunnels
  zone_id  = data.cloudflare_zone.zone[each.key].id
  name     = each.value.cname
  value    = cloudflare_tunnel.tunnel[each.key].cname
  type     = "CNAME"
  proxied  = true
}
