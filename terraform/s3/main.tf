data "sops_file" "secrets" {
  source_file = "../secrets.sops.yaml"
}

locals {
  secrets                = yamldecode(data.sops_file.secrets.raw)
  cloudflare_api_token   = local.secrets.cloudflare_api_token
  cloudflare_account_id  = local.secrets.cloudflare_account_id
  legacy_restic_password = local.secrets.legacy_restic_password
  minio_server           = local.secrets.minio_server
  minio_username         = local.secrets.minio_username
  minio_password         = local.secrets.minio_password
  onepassword_vault_id   = local.secrets.onepassword_vault_id
  vault                  = local.onepassword_vault_id
  prefix                 = "k8s-prod"
  tags = [
    "tenant:home-ops",
    "env:prod",
    "app:minio",
    "app:r2",
    "app:volsync",
  ]
  # these have a pre-existing restic key
  legacy_buckets = [
    "volsync-calibre-web",
    "volsync-autoscan",
    "volsync-calibre",
    "volsync-calibre-web",
    "volsync-invoiceninja-mariadb",
    "volsync-invoiceninja-public",
    "volsync-jellyfin",
    "volsync-lidarr",
    "volsync-matrix-synapse-ol",
    "volsync-overseerr",
    "volsync-plex",
    "volsync-prowlarr",
    "volsync-qbittorrent",
    "volsync-radarr",
    "volsync-readarr",
    "volsync-readarr-audiobooks",
    "volsync-recyclarr",
    "volsync-sabnzbd",
    "volsync-sonarr",
    "volsync-tautulli",
  ]
  # these can have the restic key generated
  new_buckets = []
}

provider "cloudflare" {
  api_token = local.cloudflare_api_token
}

provider "minio" {
  alias        = "nas"
  minio_server = local.minio_server
  # Note: this user should have the `consoleAdmin` policy attached to it
  minio_user     = local.minio_username
  minio_password = local.minio_password
  minio_ssl      = true
}


module "volsync_bucket" {
  for_each              = toset(local.legacy_buckets)
  source                = "./modules/volsync-bucket"
  minio_server          = local.minio_server
  r2_enabled            = true
  cloudflare_account_id = local.cloudflare_account_id
  vault                 = local.vault
  bucket_name           = each.key
  tags                  = local.tags
  restic_password       = local.legacy_restic_password

  providers = {
    minio = minio.nas
  }
}

output "volsync_buckets" {
  value     = module.volsync_bucket
  sensitive = true
}
