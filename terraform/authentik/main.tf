provider "authentik" {}

provider "onepassword" {
  url = "http://onepassword-connect.k8s.socozy.casa"
  # token specified via env var
}

resource "authentik_service_connection_kubernetes" "local" {
  name       = "local"
  local      = true
  verify_ssl = false
}

data "sops_file" "secrets" {
  source_file = "../secrets.sops.yaml"
}

locals {
  secrets               = yamldecode(data.sops_file.secrets.raw)
  onepassword_vault_id  = local.secrets.onepassword_vault_id
  authentik_domain_work = "auth.${var.external_domain_work}"
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
    "container_image"                = null
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
    "kubernetes_ingress_annotations" = {
      "external-dns.alpha.kubernetes.io/target" : "external.${var.external_domain}"
    }
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
    "container_image"                = null
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
resource "authentik_brand" "work" {
  domain         = local.authentik_domain_work
  default        = false
  branding_title = "Outskirts Labs"

  branding_logo    = "/static/dist/assets/icons/work-logo.svg"
  branding_favicon = "/static/dist/assets/icons/work-favicon.png"
}

#resource "authentik_outpost" "external-work" {
#  name               = "external-work"
#  service_connection = authentik_service_connection_kubernetes.local.id
#  protocol_providers = local.external_work_proxy_provider_ids
#  config = jsonencode({
#    "log_level"                      = "info"
#    "docker_labels"                  = null
#    "authentik_host"                 = "https://${var.authentik_domain_work}/"
#    "docker_network"                 = null
#    "container_image"                = null
#    "docker_map_ports"               = true
#    "kubernetes_replicas"            = 1
#    "kubernetes_namespace"           = var.kubernetes_namespace
#    "authentik_host_browser"         = ""
#    "object_naming_template"         = "ak-outpost-%(name)s"
#    "authentik_host_insecure"        = false
#    "kubernetes_json_patches"        = null
#    "kubernetes_service_type"        = "ClusterIP"
#    "kubernetes_image_pull_secrets"  = []
#    "kubernetes_ingress_class_name"  = "external-work"
#    "kubernetes_disabled_components" = []
#    "kubernetes_ingress_annotations" = {
#      "external-dns.alpha.kubernetes.io/target" : "external.${var.external_domain_work}"
#    }
#    "kubernetes_ingress_secret_name" = "authentik-outpost-tls"
#  })
#}


output "outpost_svc_hostname_external" {
  value = "ak-outpost-${authentik_outpost.external.name}.${var.kubernetes_namespace}.svc.cluster.local"
}

output "outpost_svc_hostname_internal" {
  value = "ak-outpost-${authentik_outpost.internal.name}.${var.kubernetes_namespace}.svc.cluster.local"
}
