output "bucket_id" {
  value     = minio_s3_bucket.bucket.id
  sensitive = false
}
output "user_access_key" {
  value = var.owner_access_key
}
output "user_secret_key" {
  value = var.owner_secret_key
}
