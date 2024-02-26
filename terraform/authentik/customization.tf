resource "authentik_policy_password" "password-complexity" {
  name                    = "password-complexity"
  check_have_i_been_pwned = true
  length_min              = 10
  error_message           = "Password must be at least 10 characters long and not be a commonly used password."
}
