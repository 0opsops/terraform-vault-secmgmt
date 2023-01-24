terraform {
  required_version = ">= v1.1.8"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.12.0"
    }
  }

  backend "s3" {
    bucket  = "BUCKET_NAME"             # Replace state file bucket nmae
    key     = "STATE_FILE_NAME.tfstate" # Replace state file name
    region  = "AWS_REGION"
    encrypt = true
  }
}

provider "vault" {
  address = var.vault_addr # Vault URL
  token   = var.token      # Token
}


module "vault" {
  # source                = "git::github.com/0opsops/terraform-vault-secmgmt.git?ref=v1.0.0" ## using specific tags
  # source                = "git::github.com/0opsops/terraform-vault-secmgmt.git"
  source = "0opsops/secmgmt/vault"
  # version               = "v1.0.0"
  create_mountpath = var.create_mountpath
  vault_mount      = var.vault_mount
  create_kv_v2     = var.create_kv_v2
  kv_v2            = var.kv_v2
  create_policy    = var.create_policy
  vault_policy     = var.vault_policy

  ## VAULT USERPASS
  create_userpass = var.create_userpass
  users_path      = var.users_path

  ## Assume Role
  access_key                 = var.access_key
  secret_key                 = var.secret_key
  create_aws_auth_backend    = var.create_aws_auth_backend
  create_aws_secret_backend  = var.create_aws_secret_backend
  default_ttl_aws            = var.default_ttl_aws
  max_ttl_aws                = var.max_ttl_aws
  aws_auth_path              = var.aws_auth_path
  aws_secret_path            = var.aws_secret_path
  create_auth_backend_role   = var.create_auth_backend_role
  auth_backend_role          = var.auth_backend_role
  create_secret_backend_role = var.create_secret_backend_role
  secret_backend_role        = var.secret_backend_role
  credential_type            = var.credential_type
  region                     = var.region

  ## IAM User
  access_key_user                 = var.access_key_user
  secret_key_user                 = var.secret_key_user
  create_aws_auth_backend_user    = var.create_aws_auth_backend_user
  create_aws_secret_backend_user  = var.create_aws_secret_backend_user
  default_ttl_user                = var.default_ttl_user
  max_ttl_user                    = var.max_ttl_user
  aws_auth_path_user              = var.aws_auth_path_user
  aws_secret_path_user            = var.aws_secret_path_user
  create_auth_backend_role_user   = var.create_auth_backend_role_user
  auth_backend_role_user          = var.auth_backend_role_user
  create_secret_backend_role_user = var.create_secret_backend_role_user
  secret_backend_role_user        = var.secret_backend_role_user
  credential_type_user            = var.credential_type_user
  region_user                     = var.region_user

  ## JWT
  enabled_jwt_backend   = var.enabled_jwt_backend
  jwt_path              = var.jwt_path
  create_acc_role       = var.create_acc_role
  create_secret_role    = var.create_secret_role
  bound_issuer          = var.bound_issuer
  default_ttl_jwt       = var.default_ttl_jwt
  max_ttl_jwt           = var.max_ttl_jwt
  acc_token_policies    = var.acc_token_policies
  acc_bound_claims      = var.acc_bound_claims
  secret_token_policies = var.secret_token_policies
  secret_bound_claims   = var.secret_bound_claims
}

