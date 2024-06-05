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

data "authentik_flow" "default-provider-authorization-explicit-consent" {
  slug = "default-provider-authorization-explicit-consent"
}


# Recovery flow
resource "authentik_flow" "recovery" {
  name               = "recovery-flow"
  title              = "Password recovery"
  slug               = "password-recovery"
  designation        = "recovery"
  compatibility_mode = true
  # background         = "https://placeholder.jpeg"
}

resource "authentik_flow_stage_binding" "recovery-flow-binding-00" {
  target = authentik_flow.recovery.uuid
  stage  = authentik_stage_identification.recovery-identification.id
  order  = 0
}

#resource "authentik_flow_stage_binding" "recovery-flow-binding-10" {
#  target = authentik_flow.recovery.uuid
#  stage  = authentik_stage_email.recovery-email.id
#  order  = 10
#}

resource "authentik_flow_stage_binding" "recovery-flow-binding-20" {
  target = authentik_flow.recovery.uuid
  stage  = authentik_stage_prompt.password-change-prompt.id
  order  = 20
}

resource "authentik_flow_stage_binding" "recovery-flow-binding-30" {
  target = authentik_flow.recovery.uuid
  stage  = authentik_stage_user_write.password-change-write.id
  order  = 30
}


## User settings flow
resource "authentik_flow" "user-settings" {
  name               = "User settings"
  title              = "Update your info"
  slug               = "user-settings-flow"
  policy_engine_mode = "any"
  denied_action      = "message_continue"
  designation        = "stage_configuration"
  # background         = "https://placeholder.jpeg"
}

resource "authentik_flow_stage_binding" "user-settings-flow-binding-20" {
  target = authentik_flow.user-settings.uuid
  stage  = authentik_stage_prompt.user-settings.id
  order  = 20
}

resource "authentik_flow_stage_binding" "user-settings-flow-binding-100" {
  target = authentik_flow.user-settings.uuid
  stage  = authentik_stage_user_write.user-settings-write.id
  order  = 100
}
