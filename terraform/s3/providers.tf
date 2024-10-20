terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.9.0"
    }
    minio = {
      source  = "aminueza/minio"
      version = "2.5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.43.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
  }
}
