terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.7.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.3.0"
    }
  }
}
