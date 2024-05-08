terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.9"
    }
    minio = {
      source  = "aminueza/minio"
      version = "2.2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.32.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.4.3"
    }
  }
}
