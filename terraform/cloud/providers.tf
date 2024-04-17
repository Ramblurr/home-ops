terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.30.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.4.3"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
  }
}
