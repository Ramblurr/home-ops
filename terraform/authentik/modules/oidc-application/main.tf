terraform {
  required_providers {
    authentik = {
      source = "goauthentik/authentik"
    }
    onepassword = {
      source = "1Password/onepassword"
    }
  }
}

variable "name" {
  type = string
}
variable "authentik_domain" {
  type = string
}
variable "vault" {
  type    = string
  default = null
}
variable "tags" {
  type    = list(string)
  default = []
}
variable "domain" {
  type = string
}
variable "access_token_validity" {
  type    = string
  default = "weeks=8"
}
variable "authorization_flow_id" {
  type = string
}

variable "meta_icon" {
  type    = string
  default = null
}
variable "meta_description" {
  type    = string
  default = null
}
variable "group" {
  type = string
}
variable "policy_engine_mode" {
  type    = string
  default = "any"
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type        = string
  description = "(Optional) Randomly generated if needed and not required "
  sensitive   = true
  default     = null
}

variable "client_type" {
  type    = string
  default = "confidential"
}
variable "authentication_flow_id" {
  type = string
}
variable "redirect_uris" {
  type = list(string)
}

variable "property_mappings" {
  type    = list(string)
  default = null
}

locals {
  # only need a client secret when its a confidential client type
  client_secret = (
    var.client_type == "confidential"
    ? var.client_secret != null ? var.client_secret : random_password.client_secret.result
    : null
  )
  oidc_url_prefix = "https://${var.authentik_domain}/application/o"
}

resource "random_password" "client_secret" {
  length = 52
}

resource "authentik_provider_oauth2" "main" {
  name                  = var.name
  client_id             = var.client_id
  client_type           = var.client_type
  client_secret         = local.client_secret
  authorization_flow    = var.authorization_flow_id
  authentication_flow   = var.authentication_flow_id
  redirect_uris         = var.redirect_uris
  access_token_validity = var.access_token_validity
  property_mappings     = var.property_mappings
}

resource "authentik_application" "main" {
  name               = title(var.name)
  slug               = var.name
  group              = var.group
  policy_engine_mode = "any"
  meta_launch_url    = "https://${var.domain}"
  meta_icon          = var.meta_icon
  meta_description   = var.meta_description
  protocol_provider  = authentik_provider_oauth2.main.id
}

resource "onepassword_item" "item" {
  count    = var.client_type == "confidential" ? 1 : 0
  vault    = var.vault
  title    = "authentik-oidc-${var.name}"
  category = "login"
  tags     = sort(var.tags)
  section {
    label = "authentik"
    field {
      label = "CLIENT_SECRET"
      value = local.client_secret
      type  = "CONCEALED"
    }
    field {
      label = "CLIENT_ID"
      value = var.client_id
      type  = "CONCEALED"
    }
    field {
      label = "config_url"
      value = "${local.oidc_url_prefix}/${var.name}/.well-known/openid-configuration"
      type  = "STRING"
    }
    field {
      label = "issuer_url"
      value = "${local.oidc_url_prefix}/${var.name}/"
      type  = "STRING"
    }
    field {
      label = "authorize_url"
      value = "${local.oidc_url_prefix}/authorize/"
      type  = "STRING"
    }
    field {
      label = "token_url"
      value = "${local.oidc_url_prefix}/token/"
      type  = "STRING"
    }
    field {
      label = "userinfo_url"
      value = "${local.oidc_url_prefix}/userinfo/"
      type  = "STRING"
    }
    field {
      label = "logout_url"
      value = "${local.oidc_url_prefix}/${var.name}/end-session/"
      type  = "STRING"
    }
    field {
      label = "jwks_url"
      value = "${local.oidc_url_prefix}/${var.name}/jwks/"
      type  = "STRING"
    }
  }
}

output "application_id" {
  value = authentik_application.main.uuid
}
output "oauth2_provider_id" {
  value = authentik_provider_oauth2.main.id
}
