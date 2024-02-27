
locals {
  icon_base = "https://raw.githubusercontent.com/ramblurr/home-ops/main/icons"
  external_proxy_provider_ids = [
    module.calibre-web.proxy_provider_id,
    module.radicale.proxy_provider_id
  ]
  internal_proxy_provider_ids = [
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
  ])

  household_app_ids = toset([
    module.paperless.application_id,
    module.radicale.application_id,
  ])
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

module "radicale" {
  source                  = "./modules/forward-auth-application"
  name                    = "radicale"
  domain                  = "radicale.${var.external_domain}"
  group                   = "Home"
  mode                    = "proxy"
  internal_host           = "http://radicale.home-radicale.svc.cluster.local:5232"
  authorization_flow_uuid = local.implicit_authorization_flow
  meta_icon               = "${local.icon_base}/radicale.png"
  property_mappings       = [authentik_scope_mapping.radicale_username.id]
}

locals {
  work_ocis_name   = "Outskirts Labs Data"
  work_ocis_domain = "data.${var.external_domain_work}"
}


module "work-ocis-web" {
  source                 = "./modules/oidc-application"
  name                   = "${local.work_ocis_name} - web"
  slug                   = "work-ocis"
  client_type            = "public"
  client_id              = "work-ocis"
  domain                 = local.work_ocis_domain
  group                  = "Work"
  authorization_flow_id  = local.explicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  authentik_domain       = var.authentik_domain_work
  meta_launch_url        = "https://${local.work_ocis_domain}"
  meta_icon              = "${local.icon_base}/owncloud.png"
  property_mappings      = data.authentik_scope_mapping.oauth2.ids
  redirect_uris = [
    "https://${local.work_ocis_domain}/",
    "https://${local.work_ocis_domain}/oidc-callback.html",
    "https://${local.work_ocis_domain}/oidc-silent-redirect.html"
  ]
}
module "work-ocis-desktop" {
  source                 = "./modules/oidc-application"
  name                   = "${local.work_ocis_name} - Desktop"
  slug                   = "work-ocis-desktop"
  client_type            = "confidential"
  client_id              = "xdXOt13JKxym1B1QcEncf2XDkLAexMBFwiT9j6EfhhHFJhs2KM9jbjTmf8JBXE69"
  client_secret          = "UBntmLjC2yYCeHwsyj73Uwo9TAaecAetRwMw0xYcvNL9yRdLSUi0hUAHfvCHFeFh"
  domain                 = local.work_ocis_domain
  group                  = "Work"
  authorization_flow_id  = local.explicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  authentik_domain       = var.authentik_domain_work
  meta_launch_url        = "blank://blank" # This hides the application in the library page
  meta_icon              = "${local.icon_base}/owncloud.png"
  property_mappings      = concat(data.authentik_scope_mapping.oauth2_offline.ids, data.authentik_scope_mapping.oauth2.ids)
  vault                  = local.onepassword_vault_id
  redirect_uris = [
    "http://127.0.0.1(:.*)?",
    "http://localhost(:.*)?"
  ]
}
module "work-ocis-android" {
  source                 = "./modules/oidc-application"
  name                   = "${local.work_ocis_name} - Android"
  slug                   = "work-ocis-android"
  client_id              = "e4rAsNUSIUs0lF4nbv9FmCeUkTlV9GdgTLDH1b5uie7syb90SzEVrbN7HIpmWJeD"
  client_type            = "confidential"
  client_secret          = "dInFYGV33xKzhbRmpqQltYNdfLdJIfJ9L5ISoKhNoT9qZftpdWSP71VrpGR9pmoD"
  domain                 = local.work_ocis_domain
  group                  = "Work"
  authorization_flow_id  = local.explicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  authentik_domain       = var.authentik_domain_work
  meta_launch_url        = "blank://blank" # This hides the application in the library page
  meta_icon              = "${local.icon_base}/owncloud.png"
  property_mappings      = concat(data.authentik_scope_mapping.oauth2_offline.ids, data.authentik_scope_mapping.oauth2.ids)
  vault                  = local.onepassword_vault_id
  redirect_uris = [
    "oc://android.owncloud.com",
  ]
}

module "work-ocis-ios" {
  source                 = "./modules/oidc-application"
  name                   = "${local.work_ocis_name} - iOS"
  slug                   = "work-ocis-ios"
  client_id              = "work-ocis-ios"
  client_type            = "confidential"
  domain                 = local.work_ocis_domain
  group                  = "Work"
  authorization_flow_id  = local.explicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  authentik_domain       = var.authentik_domain_work
  meta_launch_url        = "blank://blank" # This hides the application in the library page
  meta_icon              = "${local.icon_base}/owncloud.png"
  property_mappings      = concat(data.authentik_scope_mapping.oauth2_offline.ids, data.authentik_scope_mapping.oauth2.ids)
  vault                  = local.onepassword_vault_id
  redirect_uris = [
    "oc://ios.owncloud.com",
    "oc.ios://ios.owncloud.com"
  ]
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


module "paperless" {
  source                 = "./modules/oidc-application"
  name                   = "paperless"
  client_id              = "paperless"
  domain                 = "paperless.${var.internal_domain}"
  group                  = "Home"
  authorization_flow_id  = local.implicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  redirect_uris          = ["https://paperless.${var.internal_domain}/accounts/oidc/authentik/login/callback/"]
  property_mappings      = data.authentik_scope_mapping.oauth2.ids
  access_token_validity  = "hours=72"
  authentik_domain       = var.authentik_domain
  vault                  = local.onepassword_vault_id
  meta_icon              = "${local.icon_base}/paperless-ngx.png"
}
