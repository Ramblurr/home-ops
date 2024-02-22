
locals {
  icon_base = "https://raw.githubusercontent.com/ramblurr/home-ops/main/icons"
  external_proxy_provider_ids = [
    module.calibre-web.proxy_provider_id,
  ]
  internal_proxy_provider_ids = [
    module.calibre-web.proxy_provider_id,
    module.calibre.proxy_provider_id,
    module.filebrowser.proxy_provider_id,
    module.sabnzbd.proxy_provider_id,
    module.prowlarr.proxy_provider_id,
    module.sonarr.proxy_provider_id,
    module.radarr.proxy_provider_id,
  ]
  implicit_authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  default_authentication_flow = data.authentik_flow.default-authentication-flow.id
}

module "calibre-web" {
  source                  = "./modules/forward-auth-application"
  name                    = "calibre-web"
  domain                  = "books.${var.external_domain}"
  group                   = "Books"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/calibre-web.png"
}

module "calibre" {
  source                  = "./modules/forward-auth-application"
  name                    = "calibre"
  domain                  = "calibre.${var.internal_domain}"
  group                   = "admin"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/calibre.png"
}

module "filebrowser" {
  source                  = "./modules/forward-auth-application"
  name                    = "filebrowser"
  domain                  = "files.${var.internal_domain}"
  group                   = "admin"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/filebrowser.png"
}

module "radarr" {
  source                  = "./modules/forward-auth-application"
  name                    = "radarr"
  domain                  = "radarr.${var.internal_domain}"
  group                   = "admin"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/radarr.png"
}
module "sonarr" {
  source                  = "./modules/forward-auth-application"
  name                    = "sonarr"
  domain                  = "sonarr.${var.internal_domain}"
  group                   = "admin"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/sonarr.png"
}

module "prowlarr" {
  source                  = "./modules/forward-auth-application"
  name                    = "prowlarr"
  domain                  = "prowlarr.${var.internal_domain}"
  group                   = "admin"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/prowlarr.png"
}

module "sabnzbd" {
  source                  = "./modules/forward-auth-application"
  name                    = "sabnzbd"
  domain                  = "sabnzbd.${var.internal_domain}"
  group                   = "admin"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/sabnzbd.png"
}

module "ocis-test" {
  source                 = "./modules/oidc-application"
  name                   = "ocis-test"
  client_id              = "ocis-test-simple-web2"
  client_type            = "public"
  domain                 = "ocis-test-simple.${var.external_domain}"
  group                  = "Books"
  authorization_flow_id  = local.implicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  authentik_domain       = var.authentik_domain
  meta_icon              = "${local.icon_base}/owncloud.png"
  redirect_uris = [
    "https://ocis-test-simple.${var.external_domain}/",
    "https://ocis-test-simple.${var.external_domain}/oidc-callback.html",
    "https://ocis-test-simple.${var.external_domain}/oidc-silent-redirect.html"
  ]
}

module "grafana" {
  source                 = "./modules/oidc-application"
  name                   = "grafana"
  client_id              = "grafana"
  domain                 = "grafana.${var.internal_domain}"
  group                  = "Books"
  authorization_flow_id  = local.implicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  redirect_uris          = ["https://grafana.${var.internal_domain}/login/generic_oauth"]
  property_mappings      = data.authentik_scope_mapping.oauth2.ids
  access_token_validity  = "hours=4"
  authentik_domain       = var.authentik_domain
  vault                  = local.onepassword_vault_id
  meta_icon              = "${local.icon_base}/grafana.png"
}
