terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.0.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
  }
}
