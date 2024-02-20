resource "authentik_group" "users" {
  name         = "users"
  is_superuser = false
}

resource "authentik_group" "admins" {
  name         = "Admins"
  is_superuser = true
}

resource "authentik_group" "books" {
  name         = "Books"
  is_superuser = false
}

resource "authentik_group" "home" {
  name         = "Home"
  is_superuser = false
}
