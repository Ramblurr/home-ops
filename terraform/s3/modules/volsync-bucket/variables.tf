variable "bucket_name" {
  type        = string
  description = "The name of the bucket to create"
}

variable "restic_password" {
  type        = string
  default     = null
  sensitive   = true
  description = "(Optional) The encryption password to use for the restic repository, one will be generated if not provided"
}

variable "vault" {
  type        = string
  description = "The 1password vault to store the item in"
}

variable "minio_server" {
  type        = string
  description = "The hostname portion of the minio server endpoint"
}

variable "minio_server_10gbe" {
  type = string
}

variable "tags" {
  type        = list(string)
  description = "(Optional)Tags to apply to the 1password item"
  default     = []
}

variable "r2_prefix" {
  type        = string
  description = "(Optional) The prefix to use for the r2 bucket."
  default     = ""
}

variable "r2_enabled" {
  type        = bool
  description = "Whether to enable the r2 bucket"
  default     = false
}

variable "cloudflare_account_id" {
  type        = string
  description = "Required if r2 is enabled. The account id of the cloudflare account to use for the r2 bucket"
  default     = ""
}
