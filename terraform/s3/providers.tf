terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.9"
    }
    minio = {
      source  = "aminueza/minio"
      version = "2.3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.35.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.0.0"
    }
  }
}
