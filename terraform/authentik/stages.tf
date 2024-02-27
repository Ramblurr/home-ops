
## Recovery stages
resource "authentik_stage_identification" "recovery-identification" {
  name                      = "recovery-identification"
  user_fields               = ["username", "email"]
  case_insensitive_matching = false
  show_source_labels        = false
  show_matched_user         = false
}

resource "authentik_stage_email" "recovery-email" {
  name                     = "recovery-email"
  activate_user_on_success = true
  use_global_settings      = true
  template                 = "email/password_reset.html"
  subject                  = "Password recovery"
}

resource "authentik_stage_prompt" "password-change-prompt" {
  name = "password-change-prompt"
  fields = [
    resource.authentik_stage_prompt_field.password.id,
    resource.authentik_stage_prompt_field.password-repeat.id
  ]
  validation_policies = [
    resource.authentik_policy_password.password-complexity.id
  ]
}

resource "authentik_stage_user_write" "password-change-write" {
  name                     = "password-change-write"
  create_users_as_inactive = false
}


## User settings stages
resource "authentik_stage_prompt" "user-settings" {
  name = "user-settings"
  fields = [
    #resource.authentik_stage_prompt_field.username.id,
    resource.authentik_stage_prompt_field.name.id,
    resource.authentik_stage_prompt_field.email.id,
    resource.authentik_stage_prompt_field.locale.id
  ]

  validation_policies = [
    resource.authentik_policy_expression.user-settings-authorization.id
  ]

}

resource "authentik_stage_user_write" "user-settings-write" {
  name                     = "user-settings-write"
  create_users_as_inactive = false
}
