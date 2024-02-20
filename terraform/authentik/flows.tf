resource "authentik_flow" "provider-authorization-implicit-consent" {
  name               = "Authorize Application"
  title              = "Redirecting to %(app)s"
  slug               = "provider-authorization-implicit-consent"
  policy_engine_mode = "any"
  denied_action      = "message_continue"
  designation        = "authorization"
  # background         = "https://placeholder.jpeg"
}

data "authentik_flow" "default-authentication-flow" {
  slug = "default-authentication-flow"
}
