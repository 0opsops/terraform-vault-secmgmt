## Secrets
variable "create_mountpath" {
  type        = bool
  description = "Enable KV-V2 secret engine path"
}

variable "vault_mount" {
  type = map(object({
    path        = string
    type        = string
    description = string
  }))
  description = "KV-V2 secret engine path"
}

variable "create_kv_v2" {
  type        = bool
  description = "Enable KV Version 2 Secrets or not"
}

variable "kv_v2" {
  type = map(object({
    sub_path            = string
    disable_read        = bool
    delete_all_versions = bool
    data_json           = any
  }))
  description = "Key/Value store"
}

variable "max_versions" {
  type        = number
  default     = 100
  description = "Maximum versions of the secrets"
}

variable "delete_version_after" {
  type        = number
  default     = 604800
  description = "Old secrets version will be deleted after this seconds"
}

variable "create_policy" {
  type        = bool
  description = "Enable Vault policy or not"
}

variable "vault_policy" {
  type = map(object({
    name   = string
    policy = any
  }))
  description = "Policy to read secret by path"
}



## VAULT USERPASS
variable "create_userpass" {
  default     = false
  type        = bool
  description = "Authenticate Vault with Username/Password"
}

variable "users_path" {
  type = map(object({
    path      = string
    data_json = any
  }))
  description = ""
}



## ASSUMED ROLE
variable "create_aws_auth_backend" {
  type        = bool
  description = "Enable AWS Auth method or not"
}

variable "aws_auth_path" {
  type        = string
  description = "AWS Authentication Methods path"
}

variable "create_aws_secret_backend" {
  type        = bool
  description = "Enable AWS Secret Method or not for Vault"
}

variable "access_key" {
  type        = string
  description = "AWS Assumed Role access key"
}

variable "secret_key" {
  type        = string
  description = "AWS Assumed Role secret key"
}

variable "default_ttl_aws" {
  type        = string
  default     = 1800
  description = "Default Time To Live for Assumed role"
}

variable "max_ttl_aws" {
  type        = string
  default     = 3600
  description = "Maximum Time To Live for Assumed role"
}

variable "aws_secret_path" {
  type        = string
  description = "AWS Secret Engine path for Assumed Role"
}

variable "create_auth_backend_role" {
  type        = bool
  description = "Enable STS role or not for Vault"
}

variable "auth_backend_role" {
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  description = "Role that will be used by Vault authenticating AWS"
}

variable "create_secret_backend_role" {
  type        = bool
  description = "Enable a role on an AWS Secret Method or not for Vault"
}

variable "secret_backend_role" {
  type = map(object({
    name      = string
    role_arns = list(string)
  }))
  description = "Create and use STS Assumed Role by Vault performing necessary actions respectively"
}

variable "credential_type" {
  type        = string
  default     = "assumed_role"
  description = "AWS STS Assumed Role type"
}

variable "region" {
  type        = string
  description = "Region that Vault residing"
}



## AWS IAM User
variable "create_aws_auth_backend_user" {
  type        = bool
  default     = false
  description = "Enable AWS Auth method or not"
}

variable "aws_auth_path_user" {
  type        = string
  description = "AWS Authentication Methods path"
}

variable "create_aws_secret_backend_user" {
  type        = bool
  description = "Enable AWS Secret Method or not for Vault"
}

variable "access_key_user" {
  type        = string
  description = "AWS access key"
}

variable "secret_key_user" {
  type        = string
  description = "AWS secret key"
}

variable "default_ttl_user" {
  type        = number
  default     = 2700
  description = "Default Time To Live"
}

variable "max_ttl_user" {
  type        = number
  default     = 3600
  description = "Maximum Time To Live"
}

variable "aws_secret_path_user" {
  type        = string
  description = "AWS Secret engine path for IAM User"
}

variable "region_user" {
  type        = string
  description = "Region that Vault residing"
}

variable "create_auth_backend_role_user" {
  type        = bool
  description = "Enable STS role or not on Vault"
}

variable "auth_backend_role_user" {
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  description = "If enabled, This Role that will be used by Vault authenticating and performing necessary actions"
}

variable "create_secret_backend_role_user" {
  type        = bool
  description = "Enable a role on an AWS Secret Method for Vault"
}

variable "secret_backend_role_user" {
  type = map(object({
    name            = string
    policy_document = any
  }))
  description = "IAM User with defined IAM permission policy respectively"
}

variable "credential_type_user" {
  type        = string
  default     = "iam_user"
  description = "AWS IAM User type"
}



## JWT
variable "enabled_jwt_backend" {
  type        = bool
  description = "Enable JWT Auth Method or not"
}

variable "jwt_path" {
  type        = string
  description = "JWT Authentication path"
}

variable "bound_issuer" {
  type        = string
  description = "The value against which to match the iss claim in a JWT"
}

variable "default_ttl_jwt" {
  type        = string
  default     = "60m"
  description = "Default Time To Live"
}

variable "max_ttl_jwt" {
  type        = string
  default     = "120m"
  description = "Maximum Time To Live"
}

variable "create_acc_role" {
  type        = bool
  description = "Enable Account JWT Auth Method Role or not"
}

variable "acc_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  description = "JWT/OIDC auth Method role for AWS Account in a Vault server"
}

variable "acc_token_policies" {
  type        = list(string)
  description = "AWS Accounts policy name"
}

variable "create_secret_role" {
  type        = bool
  description = "Enable Secrets JWT Auth Method Role or not"
}

variable "secret_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  description = "JWT/OIDC auth Method role for Secrets values in a Vault server"
}

variable "secret_token_policies" {
  type        = list(string)
  description = "Secrets policy name"
}
