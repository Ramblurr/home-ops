terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.12"
    }
    minio = {
      source  = "aminueza/minio"
      version = "2.4.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.38.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.0"
    }
  }
}
