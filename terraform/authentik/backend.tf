terraform {
  backend "s3" {
    key = "authentik.tfstate"
    # Do not change
    bucket = "home-ops-terraform"
    # note: endpoint, region access key and secret key are declared in ../.envrc
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}
