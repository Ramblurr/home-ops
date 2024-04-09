terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    http = {
      source = "hashicorp/http"
    }
    onepassword = {
      source = "1Password/onepassword"
    }
  }
}
