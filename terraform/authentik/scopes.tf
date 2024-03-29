data "authentik_scope_mapping" "oauth2" {
  managed_list = [
    "goauthentik.io/providers/oauth2/scope-openid",
    "goauthentik.io/providers/oauth2/scope-email",
    "goauthentik.io/providers/oauth2/scope-profile"
  ]
}

data "authentik_scope_mapping" "oauth2_offline" {
  managed_list = [
    "goauthentik.io/providers/oauth2/scope-offline_access"
  ]
}
