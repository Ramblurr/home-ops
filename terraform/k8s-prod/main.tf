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

output "controlplane" {
  value     = proxmox_vm_qemu.controlplane
  sensitive = true
}

output "worker" {
  value     = proxmox_vm_qemu.controlplane
  sensitive = true
}

resource "proxmox_vm_qemu" "controlplane" {
  for_each = var.control_plane_nodes

  name        = "${var.cluster_name}-cp-${each.value.idx}"
  onboot      = true
  iso         = var.iso_image_location
  target_node = each.value.target_node
  full_clone  = false
  agent       = each.value.agent
  vmid        = each.value.vmid
  vga {
    type   = "virtio"
    memory = 32
  }
  qemu_os = "l26" # Linux kernel type
  memory  = each.value.memory
  cores   = each.value.cores
  sockets = each.value.sockets
  numa    = true
  hotplug = "network,disk,usb"

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
    size    = var.control_plane_boot_disk_size
    storage = var.control_plane_boot_disk_storage_pool
    backup  = true
  }

}


resource "proxmox_vm_qemu" "workers" {
  for_each    = var.worker_nodes
  name        = "${var.cluster_name}-wrk-${each.value.idx}"
  onboot      = true
  iso         = var.iso_image_location
  target_node = each.value.target_node
  full_clone  = false
  agent       = each.value.agent
  vmid        = each.value.vmid
  vga {
    type   = "virtio"
    memory = 32
  }
  qemu_os = "l26" # Linux kernel type
  memory  = each.value.memory
  cores   = each.value.cores
  sockets = each.value.sockets
  numa    = true
  hotplug = "network,disk,usb"

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
    size    = var.worker_boot_disk_size
    storage = var.worker_boot_disk_storage_pool
    backup  = true
  }

}
