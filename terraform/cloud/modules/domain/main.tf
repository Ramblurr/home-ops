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

variable "subdomains" {
  type = map(object({
    subdomain = string
  }))
  default = null
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.domain
  }
}

resource "cloudflare_zone_settings_override" "cloudflare_settings" {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
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

data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}

#resource "cloudflare_record" "ipv4" {
#  name    = "ipv4"
#  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
#  value   = chomp(data.http.ipv4.response_body)
#  proxied = true
#  type    = "A"
#  ttl     = 1
#}

resource "cloudflare_record" "root" {
  count   = var.root_record_enabled ? 1 : 0
  name    = var.domain
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ipv4.${var.domain}"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "subdomains" {
  for_each = var.subdomains == null ? {} : var.subdomains
  name     = each.value.subdomain
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "ipv4.${var.domain}"
  proxied  = true
  type     = "CNAME"
  ttl      = 1
}


resource "cloudflare_record" "caldav" {
  count   = var.dav_enabled ? 1 : 0
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
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
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
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
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
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
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
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
