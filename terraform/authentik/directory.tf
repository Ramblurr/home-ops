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

resource "authentik_group" "homedata_superuser" {
  name         = "HomeDataSuperuser"
  is_superuser = false
}

resource "authentik_group" "homedata_spaceadmin" {
  name         = "HomeDataSpaceAdmin"
  is_superuser = false
}

resource "authentik_group" "homedata_user" {
  name         = "HomeDataUser"
  is_superuser = false
}

resource "authentik_group" "homedata_guest" {
  name         = "HomeDataGuest"
  is_superuser = false
}

resource "authentik_group" "workdata_superuser" {
  name         = "WorkDataSuperuser"
  is_superuser = false
}

resource "authentik_group" "workdata_spaceadmin" {
  name         = "WorkDataSpaceAdmin"
  is_superuser = false
}

resource "authentik_group" "workdata_user" {
  name         = "WorkDataUser"
  is_superuser = false
}

resource "authentik_group" "workdata_guest" {
  name         = "WorkDataGuest"
  is_superuser = false
}

resource "authentik_policy_binding" "readers" {
  target = module.calibre-web.application_id
  group  = authentik_group.books.id
  order  = 0
}

resource "authentik_policy_binding" "admins" {
  for_each = local.admin_app_ids
  target   = each.value
  group    = authentik_group.admins.id
  order    = 0
}

resource "authentik_policy_binding" "home" {
  for_each = local.household_apps
  target   = each.value
  group    = authentik_group.home.id
  order    = 0
}
