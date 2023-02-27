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
  # source                = "git::github.com/0opsops/terraform-vault-secmgmt.git"   ## latest
  source  = "0opsops/secmgmt/vault"
  version = "v3.0.0"


  ## KV VERSION 2 SECRETS
  create_kv_engine = var.create_kv_engine
  kv_v2_path       = var.kv_v2_path
  create_kv_v2     = var.create_kv_v2
  kv_v2            = var.kv_v2


  ## VAULT POLICY
  create_policy = var.create_policy
  vault_policy  = var.vault_policy


  ## VAULT USERPASS
  create_userpass = var.create_userpass
  users_path      = var.users_path


  ## AWS ASSUMED ROLE USER
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


  ## AWS IAM USER
  access_key_user                 = var.access_key_user
  secret_key_user                 = var.secret_key_user
  create_aws_auth_backend_user    = var.create_aws_auth_backend_user
  aws_auth_path_user              = var.aws_auth_path_user
  create_aws_secret_backend_user  = var.create_aws_secret_backend_user
  aws_secret_path_user            = var.aws_secret_path_user
  create_auth_backend_role_user   = var.create_auth_backend_role_user
  auth_backend_role_user          = var.auth_backend_role_user
  create_secret_backend_role_user = var.create_secret_backend_role_user
  secret_backend_role_user        = var.secret_backend_role_user
  credential_type_user            = var.credential_type_user
  default_ttl_user                = var.default_ttl_user
  max_ttl_user                    = var.max_ttl_user
  region_user                     = var.region_user


  ## GITLAB JWT/OIDC
  enabled_gl_jwt_backend = var.enabled_gl_jwt_backend
  gl_jwt_path            = var.gl_jwt_path
  bound_issuer           = var.bound_issuer
  default_ttl_gl_jwt     = var.default_ttl_gl_jwt
  max_ttl_gl_jwt         = var.max_ttl_gl_jwt
  gl_jwt_token_type      = var.gl_jwt_token_type


  create_gl_acc_role    = var.create_gl_acc_role
  gl_acc_bound_claims   = var.gl_acc_bound_claims
  gl_acc_token_policies = var.gl_acc_token_policies

  create_gl_secret_role    = var.create_gl_secret_role
  gl_secret_bound_claims   = var.gl_secret_bound_claims
  gl_secret_token_policies = var.gl_secret_token_policies


  ## GITHUB JWT/OIDC
  enabled_gh_jwt_backend = var.enabled_gh_jwt_backend
  gh_jwt_path            = var.gh_jwt_path
  default_ttl_gh_jwt     = var.default_ttl_gh_jwt
  max_ttl_gh_jwt         = var.max_ttl_gh_jwt
  gh_jwt_token_type      = var.gh_jwt_token_type


  create_gh_acc_role    = var.create_gh_acc_role
  gh_acc_bound_claims   = var.gh_acc_bound_claims
  gh_acc_token_policies = var.gh_acc_token_policies
  gh_acc_bound_aud      = var.gh_acc_bound_aud
  gh_acc_bound_sub      = var.gh_acc_bound_sub

  create_gh_secret_role    = var.create_gh_secret_role
  gh_secret_bound_claims   = var.gh_secret_bound_claims
  gh_secret_token_policies = var.gh_secret_token_policies
  gh_secret_bound_aud      = var.gh_secret_bound_aud
  gh_secret_bound_sub      = var.gh_secret_bound_sub
}

