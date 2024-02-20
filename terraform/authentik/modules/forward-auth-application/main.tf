terraform {
  required_providers {
    authentik = {
      source = "goauthentik/authentik"
    }
  }
}

variable "name" {
  type = string
}
variable "domain" {
  type = string
}
variable "access_token_validity" {
  type    = string
  default = "weeks=8"
}
variable "authorization_flow_uuid" {
  type = string
}

variable "meta_icon" {
  type    = string
  default = null
}
variable "group" {
  type = string
}
variable "policy_engine_mode" {
  type    = string
  default = "all"
}

resource "authentik_provider_proxy" "main" {
  name                  = var.name
  external_host         = "http://${var.domain}"
  mode                  = "forward_single"
  authorization_flow    = var.authorization_flow_uuid
  access_token_validity = var.access_token_validity
}


resource "authentik_application" "main" {
  name               = title(var.name)
  slug               = var.name
  protocol_provider  = authentik_provider_proxy.main.id
  group              = var.group
  open_in_new_tab    = true
  meta_icon          = var.meta_icon
  policy_engine_mode = var.policy_engine_mode
}

output "application_id" {
  value = authentik_application.main.id
}
output "proxy_provider_id" {
  value = authentik_provider_proxy.main.id
}
