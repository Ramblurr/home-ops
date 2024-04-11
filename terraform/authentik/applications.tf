
locals {
  icon_base = "https://raw.githubusercontent.com/ramblurr/home-ops/main/icons"
  external_proxy_provider_ids = [
    module.calibre-web.proxy_provider_id,
    module.linkding.proxy_provider_id
  ]
  internal_proxy_provider_ids = [
    module.archivebox.proxy_provider_id,
    module.calibre-web.proxy_provider_id,
    module.calibre.proxy_provider_id,
    module.filebrowser.proxy_provider_id,
    module.sabnzbd.proxy_provider_id,
    module.prowlarr.proxy_provider_id,
    module.sonarr.proxy_provider_id,
    module.radarr.proxy_provider_id
  ]
  external_work_proxy_provider_ids = [
  ]
  implicit_authorization_flow = resource.authentik_flow.provider-authorization-implicit-consent.uuid
  explicit_authorization_flow = data.authentik_flow.default-provider-authorization-explicit-consent.id
  default_authentication_flow = data.authentik_flow.default-authentication-flow.id

  admin_app_ids = toset([
    module.grafana.application_id,
    module.calibre.application_id,
    module.filebrowser.application_id,
    module.sabnzbd.application_id,
    module.prowlarr.application_id,
    module.sonarr.application_id,
    module.radarr.application_id,
    module.grafana.application_id,
    module.linkding.application_id
  ])

  household_app_ids = toset([
    #module.paperless.application_id,
    module.home-ocis-web.application_id

  ])
}

module "archivebox" {
  source                  = "./modules/forward-auth-application"
  name                    = "archivebox"
  domain                  = "archive.${var.external_domain}"
  group                   = "Home"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/archivebox.png"
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

module "paperless" {
  source                  = "./modules/forward-auth-application"
  name                    = "paperless"
  domain                  = "paperless.${var.internal_domain}"
  group                   = "Home"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/paperless.png"
}

module "linkding" {
  source                  = "./modules/forward-auth-application"
  name                    = "linkding"
  domain                  = "bookmarks.${var.external_domain}"
  group                   = "Home"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/linkding.png"
  skip_path_regex         = "/api/"
}

module "grafana" {
  source                 = "./modules/oidc-application"
  name                   = "grafana"
  client_id              = "grafana"
  domain                 = "grafana.${var.internal_domain}"
  group                  = "Books"
  authorization_flow_id  = local.explicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  redirect_uris          = ["https://grafana.${var.internal_domain}/login/generic_oauth"]
  property_mappings      = data.authentik_scope_mapping.oauth2.ids
  access_token_validity  = "hours=4"
  authentik_domain       = var.authentik_domain
  vault                  = local.onepassword_vault_id
  meta_icon              = "${local.icon_base}/grafana.png"
}


#module "paperless" {
#  source                 = "./modules/oidc-application"
#  name                   = "paperless"
#  client_id              = "paperless"
#  domain                 = "paperless.${var.internal_domain}"
#  group                  = "Home"
#  authorization_flow_id  = local.implicit_authorization_flow
#  authentication_flow_id = local.default_authentication_flow
#  redirect_uris          = ["https://paperless.${var.internal_domain}/accounts/oidc/authentik/login/callback/"]
#  property_mappings      = data.authentik_scope_mapping.oauth2.ids
#  access_token_validity  = "hours=72"
#  authentik_domain       = var.authentik_domain
#  vault                  = local.onepassword_vault_id
#  meta_icon              = "${local.icon_base}/paperless-ngx.png"
#}
