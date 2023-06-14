variable "cluster_name" {
  type = string
}
variable "iso_image_location" {
  description = "The location of the Talos iso image on the proxmox host (<storage pool>:<content type>/<file name>.iso)."
  type        = string
}

variable "control_plane_boot_disk_storage_pool" {
  description = "The name of the storage pool where boot disks for the cluster nodes will be stored."
  type        = string
}

variable "worker_boot_disk_storage_pool" {
  description = "The name of the storage pool where boot disks for the cluster nodes will be stored."
  type        = string
}

variable "control_plane_boot_disk_size" {
  description = "The size of the boot disks. A numeric string with G, M, or K appended ex: 512M or 32G."
  type        = string
}

variable "worker_boot_disk_size" {
  description = "The size of the boot disks. A numeric string with G, M, or K appended ex: 512M or 32G."
  type        = string
}

variable "guest_agent_enabled" {
  description = "Whether to enable the Proxmox guest agent."
  type        = number
  default     = 0
}

variable "control_plane_nodes" {
  type = map(object({
    idx         = number
    target_node = string
    vmid        = string
    memory      = optional(string, "12288")
    cores       = optional(number, 2)
    sockets     = optional(number, 1)
    agent       = optional(number, 1)
    ifaces = map(object({
      tag            = number
      macaddr        = string
      ip             = string
      network_name   = string
      network_bridge = string
    }))
  }))
}

variable "worker_nodes" {
  type = map(object({
    idx         = number
    target_node = string
    vmid        = string
    memory      = optional(string, "40960")
    cores       = optional(number, 10)
    sockets     = optional(number, 1)
    agent       = optional(number, 1)
    ifaces = map(object({
      tag            = number
      macaddr        = string
      ip             = string
      network_name   = string
      network_bridge = string
    }))
  }))
}

variable "cluster_networks" {
  type = list(string)
}
