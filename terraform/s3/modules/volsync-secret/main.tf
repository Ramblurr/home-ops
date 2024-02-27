terraform {
  required_providers {
    onepassword = {
      source = "1Password/onepassword"
    }
  }
}

resource "onepassword_item" "item" {
  vault    = var.vault
  title    = var.name
  category = "login"
  tags     = sort(var.tags)
  section {
    label = "minio"
    field {
      label = "MINIO_ACCESS_KEY_ID"
      value = var.minio_access_key
      type  = "CONCEALED"
    }
    field {
      label = "MINIO_SECRET_ACCESS_KEY"
      value = var.minio_secret_key
      type  = "CONCEALED"
    }
    field {
      label = "MINIO_RESTIC_REPOSITORY"
      value = "s3:https://${var.minio_server}/${var.bucket_name}/restic"
      type  = "CONCEALED"
    }
    field {
      label   = "notes"
      value   = var.notes != null ? var.notes : null
      type    = "STRING"
      purpose = "NOTES"
    }
    field {
      label = "MINIO_RESTIC_REPOSITORY_10GBE"
      value = "s3:https://${var.minio_server_10gbe}/${var.bucket_name}/restic"
      type  = "CONCEALED"
    }
  }

  section {
    label = "R2"
    field {
      label = "R2_ACCESS_KEY_ID"
      value = var.r2_access_key
      type  = "CONCEALED"
    }
    field {
      label = "R2_SECRET_ACCESS_KEY"
      value = var.r2_secret_key
      type  = "CONCEALED"
    }
    field {
      label = "R2_RESTIC_REPOSITORY"
      value = var.r2_endpoint == null ? "" : "s3:https://${var.r2_endpoint}/${var.bucket_name}/restic"
      type  = "CONCEALED"
    }
  }
  section {
    label = "restic"
    field {
      label = "RESTIC_PASSWORD"
      value = var.restic_password
      type  = "CONCEALED"
    }
  }
}

variable "r2_endpoint" {
  type        = string
  description = "Example: foobar.r2.cloudflarestorage.com"
}

variable "minio_server" {
  type = string
}

variable "minio_server_10gbe" {
  type = string
}

variable "vault" {
  type        = string
  description = "The vault to store the item in"
}

variable "name" {
  type        = string
  description = "Secret name"
}

variable "bucket_name" {
  type = string
}

variable "minio_access_key" {
  type = string
}

variable "minio_secret_key" {
  type      = string
  sensitive = true
}

variable "r2_access_key" {
  type = string
}

variable "r2_secret_key" {
  type      = string
  sensitive = true
}

variable "restic_password" {
  type        = string
  description = "Restic password for the backup"
  sensitive   = true
}

variable "tags" {
  type        = list(string)
  description = "An array of strings of the tags assigned to the item"
}

variable "notes" {
  type    = string
  default = null
}

output "id" {
  value = onepassword_item.item.id
}

output "uuid" {
  value = onepassword_item.item.uuid
}

output "item" {
  value = var.name
}
