provider "authentik" {}

resource "authentik_service_connection_kubernetes" "local" {
  name  = "local"
  local = true
}

data "sops_file" "secrets" {
  source_file = "../secrets.sops.yaml"
}

locals {
  secrets              = yamldecode(data.sops_file.secrets.raw)
  onepassword_vault_id = local.secrets.onepassword_vault_id
}

resource "authentik_outpost" "external" {
  name               = "external"
  service_connection = authentik_service_connection_kubernetes.local.id
  protocol_providers = local.external_proxy_provider_ids
  config = jsonencode({
    "log_level"                      = "info"
    "docker_labels"                  = null
    "authentik_host"                 = "https://${var.authentik_domain}/"
    "docker_network"                 = null
    "container_image"                = "ghcr.io/goauthentik/proxy:2024.2.0-rc2"
    "docker_map_ports"               = true
    "kubernetes_replicas"            = 1
    "kubernetes_namespace"           = var.kubernetes_namespace
    "authentik_host_browser"         = ""
    "object_naming_template"         = "ak-outpost-%(name)s"
    "authentik_host_insecure"        = false
    "kubernetes_json_patches"        = null
    "kubernetes_service_type"        = "ClusterIP"
    "kubernetes_image_pull_secrets"  = []
    "kubernetes_ingress_class_name"  = var.external_kubernetes_ingress_class_name
    "kubernetes_disabled_components" = []
    "kubernetes_ingress_annotations" = {}
    "kubernetes_ingress_secret_name" = "authentik-outpost-tls"
  })
}

resource "authentik_outpost" "internal" {
  name               = "internal"
  service_connection = authentik_service_connection_kubernetes.local.id
  protocol_providers = local.internal_proxy_provider_ids
  config = jsonencode({
    "log_level"                      = "info"
    "docker_labels"                  = null
    "authentik_host"                 = "https://${var.authentik_domain}/"
    "docker_network"                 = null
    "container_image"                = "ghcr.io/goauthentik/proxy:2024.2.0-rc2"
    "docker_map_ports"               = true
    "kubernetes_replicas"            = 1
    "kubernetes_namespace"           = var.kubernetes_namespace
    "authentik_host_browser"         = ""
    "object_naming_template"         = "ak-outpost-%(name)s"
    "authentik_host_insecure"        = false
    "kubernetes_json_patches"        = null
    "kubernetes_service_type"        = "ClusterIP"
    "kubernetes_image_pull_secrets"  = []
    "kubernetes_ingress_class_name"  = var.internal_kubernetes_ingress_class_name
    "kubernetes_disabled_components" = []
    "kubernetes_ingress_annotations" = {}
    "kubernetes_ingress_secret_name" = "authentik-outpost-tls"
  })
}

output "outpost_svc_hostname_external" {
  value = "ak-outpost-${authentik_outpost.external.name}.${var.kubernetes_namespace}.svc.cluster.local"
}

output "outpost_svc_hostname_internal" {
  value = "ak-outpost-${authentik_outpost.internal.name}.${var.kubernetes_namespace}.svc.cluster.local"
}