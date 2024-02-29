
locals {
  work_ocis_name   = "Outskirts Labs Data"
  work_ocis_domain = "data.${var.external_domain_work}"

  home_ocis_name   = "SoCozy Drive"
  home_ocis_domain = "drive.${var.external_domain}"
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
module "home-ocis-web" {
  source                 = "./modules/oidc-application"
  name                   = "${local.home_ocis_name} - web"
  slug                   = "home-ocis"
  client_type            = "public"
  client_id              = "home-ocis"
  domain                 = local.home_ocis_domain
  group                  = "Home"
  authorization_flow_id  = local.explicit_authorization_flow
  authentication_flow_id = local.default_authentication_flow
  authentik_domain       = var.authentik_domain
  meta_launch_url        = "https://${local.home_ocis_domain}"
  meta_icon              = "${local.icon_base}/owncloud.png"
  property_mappings      = data.authentik_scope_mapping.oauth2.ids
  redirect_uris = [
    "https://${local.home_ocis_domain}/",
    "https://${local.home_ocis_domain}/oidc-callback.html",
    "https://${local.home_ocis_domain}/oidc-silent-redirect.html"
  ]
}

resource "authentik_application" "ocis-desktop" {
  name               = "Owncloud - Desktop"
  slug               = "ocis-desktop"
  group              = "Data"
  policy_engine_mode = "any"
  meta_launch_url    = "blank://blank" # This hides the application in the library page
  protocol_provider  = authentik_provider_oauth2.ocis-desktop.id
}

resource "authentik_application" "ocis-ios" {
  name               = "Owncloud - iOS"
  slug               = "ocis-ios"
  group              = "Data"
  policy_engine_mode = "any"
  meta_launch_url    = "blank://blank" # This hides the application in the library page
  protocol_provider  = authentik_provider_oauth2.ocis-ios.id
}

resource "authentik_application" "ocis-android" {
  name               = "Owncloud - Android"
  slug               = "ocis-android"
  group              = "Data"
  policy_engine_mode = "any"
  meta_launch_url    = "blank://blank" # This hides the application in the library page
  protocol_provider  = authentik_provider_oauth2.ocis-android.id
}

resource "authentik_provider_oauth2" "ocis-desktop" {
  name                = "${local.work_ocis_name} - Desktop"
  client_type         = "confidential"
  client_id           = "xdXOt13JKxym1B1QcEncf2XDkLAexMBFwiT9j6EfhhHFJhs2KM9jbjTmf8JBXE69"
  client_secret       = "UBntmLjC2yYCeHwsyj73Uwo9TAaecAetRwMw0xYcvNL9yRdLSUi0hUAHfvCHFeFh"
  authorization_flow  = local.explicit_authorization_flow
  authentication_flow = local.default_authentication_flow
  property_mappings   = concat(data.authentik_scope_mapping.oauth2_offline.ids, data.authentik_scope_mapping.oauth2.ids)
  redirect_uris = [
    "http://127.0.0.1(:.*)?",
    "http://localhost(:.*)?"
  ]
  lifecycle {
    ignore_changes = [
      signing_key
    ]
  }
}

resource "authentik_provider_oauth2" "ocis-android" {
  name                = "${local.work_ocis_name} - Android"
  client_type         = "confidential"
  client_id           = "e4rAsNUSIUs0lF4nbv9FmCeUkTlV9GdgTLDH1b5uie7syb90SzEVrbN7HIpmWJeD"
  client_secret       = "dInFYGV33xKzhbRmpqQltYNdfLdJIfJ9L5ISoKhNoT9qZftpdWSP71VrpGR9pmoD"
  authorization_flow  = local.explicit_authorization_flow
  authentication_flow = local.default_authentication_flow
  property_mappings   = concat(data.authentik_scope_mapping.oauth2_offline.ids, data.authentik_scope_mapping.oauth2.ids)
  redirect_uris = [
    "oc://android.owncloud.com",
  ]
  lifecycle {
    ignore_changes = [
      signing_key
    ]
  }
}

resource "authentik_provider_oauth2" "ocis-ios" {
  name                = "${local.work_ocis_name} - iOS"
  client_type         = "confidential"
  authorization_flow  = local.explicit_authorization_flow
  client_id           = "mxd5OQDk6es5LzOzRvidJNfXLUZS2oN3oUFeXPP8LpPrhx3UroJFduGEYIBOxkY1"
  client_secret       = "KFeFWWEZO9TkisIQzR3fo7hfiMXlOpaqP8CFuTbSHzV1TUuGECglPxpiVKJfOXIx"
  authentication_flow = local.default_authentication_flow
  property_mappings   = concat(data.authentik_scope_mapping.oauth2_offline.ids, data.authentik_scope_mapping.oauth2.ids)
  redirect_uris = [
    "oc://ios.owncloud.com",
    "oc.ios://ios.owncloud.com"
  ]
  lifecycle {
    ignore_changes = [
      signing_key
    ]
  }
}
