terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2024.4.2"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.0"
    }
  }
}
