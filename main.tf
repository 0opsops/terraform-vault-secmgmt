## VAULT KV VERSION 2
resource "vault_mount" "this" {
  count       = var.create_kv_engine ? 1 : 0
  path        = var.kv_v2_path
  type        = "kv-v2"
  description = var.kv_v2_description
}

resource "vault_kv_secret_v2" "this" {
  for_each            = { for k, v in var.kv_v2 : k => v if var.create_kv_v2 }
  mount               = try(element(vault_mount.this.*.path, 0), "")
  name                = each.value.sub_path
  delete_all_versions = each.value.delete_all_versions
  disable_read        = each.value.disable_read
  data_json           = each.value.data_json

  custom_metadata {
    max_versions         = var.max_versions
    delete_version_after = var.delete_version_after
  }

  depends_on = [
    vault_mount.this
  ]
}



## VAULT POLICY
resource "vault_policy" "this" {
  for_each = { for k, v in var.vault_policy : k => v if var.create_policy }
  name     = each.value.name
  policy   = each.value.policy
}



## USERPASS
resource "vault_auth_backend" "userpass" {
  count       = var.create_userpass ? 1 : 0
  type        = var.userpass_path
  description = "Login with Username/Password"
}

resource "vault_generic_endpoint" "users" {
  for_each             = { for k, v in var.users_path : k => v if var.create_userpass }
  depends_on           = [vault_auth_backend.userpass]
  path                 = each.value.path
  ignore_absent_fields = true
  data_json            = each.value.data_json
}



## ASSUMED ROLE
resource "vault_auth_backend" "this" {
  count       = var.create_aws_auth_backend ? 1 : 0
  type        = "aws"
  path        = var.aws_auth_path
  description = "AWS Auth Method for GitLab CI/CD"
}

resource "vault_aws_secret_backend" "this" {
  count                     = var.create_aws_secret_backend ? 1 : 0
  description               = "AWS secret engine for GitLab CI/CD!"
  access_key                = var.access_key
  secret_key                = var.secret_key
  default_lease_ttl_seconds = var.default_ttl_aws
  max_lease_ttl_seconds     = var.max_ttl_aws
  path                      = var.aws_secret_path
  region                    = var.region
}

resource "vault_aws_auth_backend_sts_role" "this" {
  for_each   = { for k, v in var.auth_backend_role : k => v if var.create_auth_backend_role }
  backend    = try(element(vault_auth_backend.this.*.path, 0), "")
  account_id = each.value.account_id
  sts_role   = each.value.sts_role
}
resource "vault_aws_secret_backend_role" "this" {
  for_each        = { for k, v in var.secret_backend_role : k => v if var.create_secret_backend_role }
  backend         = try(element(vault_aws_secret_backend.this.*.path, 0), "")
  name            = each.value.name
  credential_type = var.credential_type
  role_arns       = each.value.role_arns
}



## AWS IAM USER
resource "vault_auth_backend" "user" {
  count       = var.create_aws_auth_backend_user ? 1 : 0
  type        = "aws"
  path        = var.aws_auth_path_user
  description = "AWS temporary IAM User accessing AWS account"
}

resource "vault_aws_secret_backend" "user" {
  count                     = var.create_aws_secret_backend_user ? 1 : 0
  description               = "AWS secret engine for Gitlab pipeline!"
  access_key                = var.access_key_user
  secret_key                = var.secret_key_user
  default_lease_ttl_seconds = var.default_ttl_user
  max_lease_ttl_seconds     = var.max_ttl_user
  path                      = var.aws_secret_path_user
  region                    = var.region_user
}

resource "vault_aws_auth_backend_sts_role" "user" {
  for_each   = { for k, v in var.auth_backend_role_user : k => v if var.create_auth_backend_role_user }
  backend    = try(element(vault_auth_backend.this.*.path, 0), "")
  account_id = each.value.account_id
  sts_role   = each.value.sts_role
}

resource "vault_aws_secret_backend_role" "user" {
  for_each        = { for k, v in var.secret_backend_role_user : k => v if var.create_secret_backend_role_user }
  backend         = try(element(vault_aws_secret_backend.user.*.path, 0), "")
  name            = each.value.name
  credential_type = var.credential_type_user
  policy_document = each.value.policy_document
}



## GITLAB JWT/OIDC
resource "vault_jwt_auth_backend" "this" {
  count        = var.enabled_gl_jwt_backend ? 1 : 0
  description  = "JWT Auth backend for GitLab CI/CD"
  path         = var.gl_jwt_path
  bound_issuer = var.bound_issuer
  jwks_url     = "https://gitlab.com/-/jwks"
  tune {
    default_lease_ttl  = var.default_ttl_gl_jwt
    max_lease_ttl      = var.max_ttl_gl_jwt
    token_type         = var.gl_jwt_token_type
    listing_visibility = "hidden"
  }
}

resource "vault_jwt_auth_backend_role" "account" {
  for_each          = { for k, v in var.acc_bound_claims : k => v if var.create_acc_role }
  backend           = try(element(vault_jwt_auth_backend.this.*.path, 0), "")
  role_name         = each.value.role_name
  token_policies    = var.acc_token_policies
  token_type        = var.gl_jwt_token_type
  bound_claims_type = each.value.bound_claims_type
  user_claim        = "user_email"
  role_type         = "jwt"
  bound_claims      = each.value.bound_claims
}

resource "vault_jwt_auth_backend_role" "secret" {
  for_each          = { for k, v in var.secret_bound_claims : k => v if var.create_secret_role }
  backend           = try(element(vault_jwt_auth_backend.this.*.path, 0), "")
  role_name         = each.value.role_name
  token_policies    = var.secret_token_policies
  token_type        = var.gl_jwt_token_type
  bound_claims_type = "glob"
  user_claim        = "user_email"
  role_type         = "jwt"
  bound_claims      = each.value.bound_claims
}



## GITHUB JWT/OIDC
resource "vault_jwt_auth_backend" "gh" {
  count              = var.enabled_gh_jwt_backend ? 1 : 0
  description        = "JWT Auth backend for GitHub CI/CD"
  path               = var.gh_jwt_path
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  tune {
    default_lease_ttl  = var.default_ttl_gh_jwt
    max_lease_ttl      = var.max_ttl_gh_jwt
    token_type         = var.gh_jwt_token_type
    listing_visibility = "hidden"
  }
}

resource "vault_jwt_auth_backend_role" "actions" {
  for_each          = { for k, v in var.gh_acc_bound_claims : k => v if var.create_gh_acc_role }
  backend           = try(element(vault_jwt_auth_backend.gh.*.path, 0), "")
  role_name         = each.value.role_name
  token_policies    = var.gh_acc_token_policies
  bound_audiences   = var.gh_bound_aud
  bound_subject     = var.gh_bound_sub
  token_type        = var.gh_jwt_token_type
  bound_claims_type = "glob"
  user_claim        = "actor"
  role_type         = "jwt"
  bound_claims      = each.value.bound_claims
  token_ttl         = each.value.token_ttl
  token_max_ttl     = each.value.token_max_ttl
}
