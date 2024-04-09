variable "vault" {
  type        = string
  description = "The vault to store the item in"
}

variable "domain" {
  type = string
}

variable "dav_enabled" {
  default = false
  type    = bool
}

variable "dav_domain" {
  type    = string
  default = null
}

variable "root_record_enabled" {
  type    = bool
  default = false
}

variable "cnames" {
  type    = map(string)
  default = null
}

variable "tunnels" {
  type = map(object({
    name  = string
    cname = string
  }))
  default = {}
}

variable "account_id" {
  type = string
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.domain
  }
}

locals {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
}

resource "cloudflare_zone_settings_override" "cloudflare_settings" {
  zone_id = local.zone_id
  settings {
    ssl                      = "strict"
    always_use_https         = "on"
    min_tls_version          = "1.2"
    opportunistic_encryption = "on"
    tls_1_3                  = "zrt"
    automatic_https_rewrites = "on"
    universal_ssl            = "on"
    browser_check            = "on"
    challenge_ttl            = 1800
    privacy_pass             = "on"
    security_level           = "medium"
    brotli                   = "on"
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }
    rocket_loader       = "on"
    always_online       = "off"
    development_mode    = "off"
    http3               = "on"
    zero_rtt            = "on"
    ipv6                = "on"
    websockets          = "on"
    opportunistic_onion = "on"
    pseudo_ipv4         = "off"
    ip_geolocation      = "on"
    email_obfuscation   = "on"
    server_side_exclude = "on"
    hotlink_protection  = "off"
    security_header {
      enabled = false
    }
  }
}

#data "http" "ipv4" {
#  url = "http://ipv4.icanhazip.com"
#}

#resource "cloudflare_record" "ipv4" {
#  name    = "ipv4"
#  zone_id = local.zone_id
#  value   = chomp(data.http.ipv4.response_body)
#  proxied = true
#  type    = "A"
#  ttl     = 1
#}

resource "cloudflare_record" "root" {
  count   = var.root_record_enabled ? 1 : 0
  name    = var.domain
  zone_id = local.zone_id
  value   = "ipv4.${var.domain}"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "cnames" {
  for_each = var.cnames == null ? {} : var.cnames
  name     = each.key
  zone_id  = local.zone_id
  value    = each.value
  proxied  = true
  type     = "CNAME"
  ttl      = 1
}


resource "cloudflare_record" "caldav" {
  count   = var.dav_enabled ? 1 : 0
  zone_id = local.zone_id
  name    = var.domain
  type    = "SRV"
  ttl     = 300

  data {
    name     = var.domain
    proto    = "_tcp"
    service  = "_caldav"
    priority = 0
    weight   = 0
    port     = 0
    target   = "."
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "caldavs" {
  count   = var.dav_enabled ? 1 : 0
  zone_id = local.zone_id
  name    = var.domain
  type    = "SRV"
  ttl     = 300

  data {
    name     = var.domain
    proto    = "_tcp"
    service  = "_caldavs"
    priority = 0
    weight   = 1
    port     = 443
    target   = var.dav_domain
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "cloudflare_record" "carddav" {
  count   = var.dav_enabled ? 1 : 0
  zone_id = local.zone_id
  name    = var.domain
  type    = "SRV"
  ttl     = 300

  data {
    name     = var.domain
    proto    = "_tcp"
    service  = "_carddav"
    priority = 0
    weight   = 0
    port     = 0
    target   = "."
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "cloudflare_record" "carddavs" {
  count   = var.dav_enabled ? 1 : 0
  zone_id = local.zone_id
  name    = var.domain
  type    = "SRV"
  ttl     = 300

  data {
    name     = var.domain
    proto    = "_tcp"
    service  = "_carddavs"
    priority = 0
    weight   = 1
    port     = 443
    target   = var.dav_domain
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_ruleset" "dav_redirect" {
  zone_id = local.zone_id
  name    = "Redirect .well-known/carddav and caldav"
  kind    = "zone"
  phase   = "http_request_dynamic_redirect"

  rules {
    action = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = "https://${var.dav_domain}/dav/"
        }
        preserve_query_string = true
      }
    }
    expression  = "(http.host eq \"${var.domain}\") and ((http.request.uri.path eq \"/.well-known/carddav\") or (http.request.uri.path eq \"/.well-known/caldav\"))"
    description = "Redirect .well-known/carddav and caldav to ${var.dav_domain}/dav/"
  }
}

resource "random_id" "cloudflare_tunnel_secret" {
  for_each    = var.tunnels
  byte_length = 35
}

resource "cloudflare_tunnel" "tunnel" {
  for_each   = var.tunnels
  account_id = var.account_id
  name       = each.value.name
  secret     = random_id.cloudflare_tunnel_secret[each.key].b64_std
  config_src = "local"
}

resource "cloudflare_record" "tunnel" {
  for_each = var.tunnels
  zone_id  = local.zone_id
  name     = each.value.cname
  value    = cloudflare_tunnel.tunnel[each.key].cname
  type     = "CNAME"
  proxied  = true
}


resource "onepassword_item" "tunnels" {
  for_each = var.tunnels
  vault    = var.vault
  title    = "cloudflare tunnel: ${each.value.name}"
  category = "login"
  section {
    label = "cloudflare tunnel"
    field {
      label = "TUNNEL_ID"
      value = cloudflare_tunnel.tunnel[each.key].id
      type  = "CONCEALED"
    }
    field {
      label = "TUNNEL_SECRET"
      value = cloudflare_tunnel.tunnel[each.key].secret
      type  = "CONCEALED"
    }
    field {
      label = "TUNNEL_CNAME"
      value = cloudflare_tunnel.tunnel[each.key].cname
      type  = "CONCEALED"
    }
    field {
      label = "TUNNEL_TOKEN"
      value = cloudflare_tunnel.tunnel[each.key].tunnel_token
      type  = "CONCEALED"
    }
    field {
      label = "ZONE_ID"
      value = local.zone_id
      type  = "CONCEALED"
    }
    field {
      label = "ACCOUNT_ID"
      value = var.account_id
      type  = "CONCEALED"
    }
  }
}

output "cloudflare_tunnels" {
  value = {
    for tunnel in cloudflare_tunnel.tunnel :
    tunnel.name => merge(tunnel, {
      account_id = var.account_id
    })
  }
  sensitive = true
}
