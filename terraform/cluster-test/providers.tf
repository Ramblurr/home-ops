terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.10"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7"
    }
    unifi = {
      source  = "paultyng/unifi"
      version = "0.41.0"
    }
  }
}
