data "sops_file" "secrets" {
  source_file = "../../ansible/inventory/host_vars/localhost/secrets.sops.yml"
}

provider "proxmox" {
  pm_user         = data.sops_file.secrets.data["proxmox_terraform_user"]
  pm_password     = data.sops_file.secrets.data["proxmox_terraform_password"]
  pm_api_url      = data.sops_file.secrets.data["proxmox_terraform_api_url"]
  pm_tls_insecure = false
  pm_debug        = false
  pm_parallel     = 25
}

provider "unifi" {
  username       = data.sops_file.secrets.data["unifi_user"]
  password       = data.sops_file.secrets.data["unifi_password"]
  api_url        = data.sops_file.secrets.data["unifi_api_url"]
  site           = data.sops_file.secrets.data["unifi_site"]
  allow_insecure = true
}

locals {
  clients = {
    for client in flatten([
      for k, node in var.control_plane_nodes : [
        for k, iface in node.ifaces : {
          name         = "${var.cluster_name}-cp-${node.idx}-${iface.network_name}"
          tag          = iface.tag
          macaddr      = iface.macaddr
          ip           = iface.ip
          network_name = iface.network_name
        }
      ]
    ]) : client.name => client
  }
}

output "clients" {
  value = local.clients
}

data "unifi_network" "net" {
  for_each = toset(var.cluster_networks)
  name     = each.value
}

resource "unifi_user" "ips" {
  for_each       = local.clients
  name           = each.value.name
  mac            = each.value.macaddr
  fixed_ip       = each.value.ip
  network_id     = data.unifi_network.net[each.value.network_name].id
  allow_existing = true
}

resource "proxmox_vm_qemu" "controlplane" {
  for_each = var.control_plane_nodes

  depends_on = [
    unifi_user.ips
  ]
  name        = "${var.cluster_name}-cp-${each.value.idx}"
  iso         = var.iso_image_location
  target_node = each.value.target_node
  full_clone  = false
  agent       = var.guest_agent_enabled
  vmid        = each.value.vmid
  qemu_os     = "l26" # Linux kernel type
  memory      = "8192"
  cores       = 4
  sockets     = 1
  numa        = true
  hotplug     = "network,disk,usb"

  dynamic "network" {
    for_each = toset(var.cluster_networks)
    content {
      model   = "virtio"
      bridge  = each.value.ifaces[network.key].network_bridge
      macaddr = each.value.ifaces[network.key].macaddr
      tag     = each.value.ifaces[network.key].tag
    }
  }

  disk {
    type    = "virtio"
    size    = var.boot_disk_size
    storage = var.boot_disk_storage_pool
  }

}
