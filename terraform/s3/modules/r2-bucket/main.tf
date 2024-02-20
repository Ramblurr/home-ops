resource "cloudflare_r2_bucket" "main" {
  account_id = var.cloudflare_account_id
  name       = var.bucket_name
  location   = "WEUR"
}

data "cloudflare_api_token_permission_groups" "all" {}

resource "cloudflare_api_token" "main" {
  name = var.bucket_name

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Read"],
      data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Write"]
    ]
    resources = {
      "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_${cloudflare_r2_bucket.main.id}" = "*"
    }
  }
}


variable "bucket_name" {
  type = string
}


variable "cloudflare_account_id" {
  type = string
}

output "id" {
  value = cloudflare_r2_bucket.main.id
}


output "bucket_name" {
  value = var.bucket_name
}

output "token" {
  value = cloudflare_api_token.main.id
}

output "endpoint" {
  value = "${var.cloudflare_account_id}.r2.cloudflarestorage.com"
}

output "access_key" {
  value = cloudflare_api_token.main.id
}

output "secret_key" {
  value = sha256(cloudflare_api_token.main.value)
}
