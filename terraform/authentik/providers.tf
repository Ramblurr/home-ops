terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2023.10.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.4.1"
    }
  }
}
