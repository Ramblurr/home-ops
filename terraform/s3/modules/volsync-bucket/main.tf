locals {
  minio_access_key = var.bucket_name
  minio_secret_key = random_password.minio_secret.result
  r2_access_key    = var.r2_enabled ? module.r2_bucket[0].access_key : null
  r2_secret_key    = var.r2_enabled ? module.r2_bucket[0].secret_key : null
  restic_password  = var.restic_password != null ? var.restic_password : random_password.restic_secret.result
}

resource "random_password" "minio_secret" {
  length = 32
}

resource "random_password" "restic_secret" {
  length = 32
}

module "minio_bucket" {
  source           = "../minio-bucket"
  bucket_name      = var.bucket_name
  is_public        = false
  owner_access_key = local.minio_access_key
  owner_secret_key = local.minio_secret_key
}

module "r2_bucket" {
  count                 = var.r2_enabled == true ? 1 : 0
  source                = "../r2-bucket"
  bucket_name           = "${var.r2_prefix}${var.bucket_name}"
  cloudflare_account_id = var.cloudflare_account_id
}

module "secret" {
  source             = "../volsync-secret"
  vault              = var.vault
  name               = var.bucket_name
  bucket_name        = var.bucket_name
  minio_access_key   = local.minio_access_key
  minio_secret_key   = local.minio_secret_key
  r2_access_key      = local.r2_access_key
  r2_secret_key      = local.r2_secret_key
  restic_password    = local.restic_password
  notes              = "This is the secret access key for the minio bucket ${var.bucket_name} and the restic repository encryption password. It is used to access the minio bucket from the k8s cluster."
  r2_endpoint        = var.r2_enabled ? module.r2_bucket[0].endpoint : null
  minio_server       = var.minio_server
  minio_server_10gbe = var.minio_server_10gbe
  tags               = sort(var.tags)
}

output "minio_access_key" {
  value = local.minio_access_key
}
output "minio_secret_key" {
  value = local.minio_secret_key
}
output "r2_access_key" {
  value = local.r2_access_key
}
output "r2_secret_key" {
  value = local.r2_secret_key
}
output "restic_password" {
  value = local.restic_password
}
output "bucket_name" {
  value = var.bucket_name
}
