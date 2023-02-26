## KV VERSION 2 SECRETS
variable "create_kv_engine" {
  type        = bool
  description = "Enable KV version 2 secret engine"
}

variable "kv_v2_path" {
  type        = string
  default     = "infra"
  description = "KV-V2 secret engine path"
}

variable "kv_v2_description" {
  type        = string
  default     = "Mount path of KV-V2 secret engine"
  description = "Just a description"
}

variable "create_kv_v2" {
  type        = bool
  description = "Create KV Version 2 Secrets"
}

variable "kv_v2" {
  type = map(object({
    sub_path            = string
    disable_read        = bool
    delete_all_versions = bool
    data_json           = any
  }))
  default = {
    "key1" = {
      data_json           = <<EOF
        {
          "key1": "value1"
        }
      EOF
      delete_all_versions = true
      disable_read        = false
      sub_path            = "path1"
    },
    "key2" = {
      data_json           = <<EOF
        {
          "key2": "value2"
        }
      EOF
      delete_all_versions = true
      disable_read        = false
      sub_path            = "path2"
    }
  }
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
  description = "Old secrets version will be deleted after this seconds (7 days)"
}


## VAULT POLICY
variable "create_policy" {
  type        = bool
  description = "Enable Vault policy or not"
}

variable "vault_policy" {
  type = map(object({
    name   = string
    policy = any
  }))
  default = {
    "key1" = {
      name   = "reader"
      policy = <<EOF
        ## Policy for only reading secrets in this path
        path "tfvars/data/*"
        {
            capabilities = ["read"]
        }
      EOF
    }
  }
  description = "Policy to read secret by path"
}


## VAULT USERPASS
variable "create_userpass" {
  type        = bool
  description = "Authenticate Vault with Username/Password"
}

variable "userpass_path" {
  type        = string
  default     = "userpass"
  description = "Mount path for `Userpass` auth method"
}

variable "users_path" {
  type = map(object({
    path      = string
    data_json = any
  }))
  default = {
    "user1" = {
      data_json = <<EOT
        {
          "policies": ["POLICY"],
          "password": "PASSWORD"
        }
      EOT
      path      = "auth/userpass/users/USERNAME"
    }
  }
  description = "The full logical path with `username` suffix"
}



## ASSUMED_ROLE
variable "create_aws_auth_backend" {
  type        = bool
  description = "Enable AWS Auth method or not"
}

variable "aws_auth_path" {
  type        = string
  default     = "aws"
  description = "AWS Authentication Methods path"
}

variable "create_aws_secret_backend" {
  type        = bool
  default     = false
  description = "Enable AWS Secret Method or not for Vault"
}

variable "access_key" {
  type        = string
  default     = "ACCESS_KEY"
  description = "AWS Assumed Role access key"
}

variable "secret_key" {
  type        = string
  default     = "SECRET_KEY"
  description = "AWS Assumed Role User secret key"
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
  default     = "aws"
  description = "AWS Secret Engine path for Assumed Role"
}


variable "create_auth_backend_role" {
  type        = bool
  default     = false
  description = "Enable STS role or not for Vault"
}

variable "auth_backend_role" {
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  default = {
    "key" = {
      account_id = 123456789012
      sts_role   = "arn:aws:iam::123456789012:role/ROLE_NAME"
    }
  }
  description = "Role that will be used by Vault authenticating AWS"
}

variable "create_secret_backend_role" {
  type        = bool
  default     = false
  description = "Enable a role on an AWS Secret Method or not for Vault"
}

variable "secret_backend_role" {
  type = map(object({
    name      = string
    role_arns = list(string)
  }))
  default = {
    "key" = {
      name      = "aws"
      role_arns = ["arn:aws:iam::123456789012:role/ROLE_NAME"]
    }
  }
  description = "Create and use STS Assumed Role by Vault performing necessary actions respectively"
}

variable "credential_type" {
  type        = string
  default     = "assumed_role"
  description = "AWS STS Assumed Role type"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region that Vault residing"
}


## AWS IAM User
variable "create_aws_auth_backend_user" {
  type        = bool
  description = "Enable AWS Auth method or not"
}

variable "aws_auth_path_user" {
  type        = string
  default     = "account_b"
  description = "AWS IAM user Authentication Methods path"
}

variable "create_aws_secret_backend_user" {
  type        = bool
  default     = false
  description = "Vault Enable AWS Secret Method or not"
}

variable "access_key_user" {
  type        = string
  default     = "ACCESS_KEY"
  description = "AWS Access Key with necessary permissions"
}

variable "secret_key_user" {
  type        = string
  default     = "SECRET_KEY"
  description = "AWS Secret Key with necessary permissions"
}

variable "default_ttl_user" {
  type        = number
  default     = 2700
  description = "Default Time To Live for AWS temporary account"
}

variable "max_ttl_user" {
  type        = number
  default     = 3600
  description = "Maximum Time To Live for AWS temporary account"
}

variable "aws_secret_path_user" {
  type        = string
  default     = "account_b"
  description = "AWS Secret engine path for IAM User"
}

variable "region_user" {
  type        = string
  default     = "us-east-1"
  description = "Region that Vault residing"
}

variable "create_auth_backend_role_user" {
  type        = bool
  default     = false
  description = "Enable STS role or not on Vault"
}

variable "auth_backend_role_user" {
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  default = {
    "key" = {
      account_id = 13456789012
      sts_role   = "value"
    }
  }
  description = "If enabled, This Role that will be used by Vault authenticating and performing necessary actions"
}

variable "create_secret_backend_role_user" {
  type        = bool
  default     = false
  description = "Enable a role on an AWS Secret Method for Vault"
}

variable "secret_backend_role_user" {
  type = map(object({
    name            = string
    policy_document = any
  }))
  default = {
    "key" = {
      name            = "value"
      policy_document = {}
    }
  }
  description = "IAM User with defined IAM permission policy respectively"
}

variable "credential_type_user" {
  type        = string
  default     = "iam_user"
  description = "AWS IAM User type"
}



## GITLAB JWT
variable "enabled_gl_jwt_backend" {
  type        = bool
  default     = false
  description = "Enable GitLab JWT Auth Method or not"
}

variable "gl_jwt_path" {
  type        = string
  default     = "jwt"
  description = "GitLab JWT Authentication path"
}

variable "bound_issuer" {
  type        = string
  default     = "gitlab.com"
  description = "The value against which to match the iss claim in a JWT"
}

variable "default_ttl_gl_jwt" {
  type        = string
  default     = "1h"
  description = "Default Time To Live"
}

variable "max_ttl_gl_jwt" {
  type        = string
  default     = "2h"
  description = "Maximum Time To Live"
}

variable "gl_jwt_token_type" {
  type        = string
  default     = "service"
  description = "`service` token or `batch` token? Default is `service` token"
}

variable "create_acc_role" {
  type        = bool
  default     = false
  description = "Enable Account Role for GitLab JWT Auth Method"
}

variable "acc_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  default = {
    "key" = {
      bound_claims = {
        "project_id" = "12312312"
        "ref"        = "main,develop"
        "ref_type"   = "branch"
      }
      role_name         = "ROLE_NAME"
      bound_claims_type = "glob"
    }
  }
  description = "JWT/OIDC auth Method role for AWS Account in a Vault server"
}

variable "acc_token_policies" {
  type        = list(string)
  default     = ["account_b"]
  description = "AWS Accounts policy name"
}

variable "create_secret_role" {
  type        = bool
  default     = false
  description = "Enable Secrets JWT Auth Method Role or not"
}

variable "secret_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  default = {
    "key" = {
      bound_claims = {
        "project_id" = "123123"
        "ref"        = "main,develop"
        "ref_type"   = "branch"
      }
      role_name = "reader-role"
    }
  }
  description = "JWT/OIDC auth Method role for Secrets values in a Vault server"
}

variable "secret_token_policies" {
  type        = list(string)
  default     = ["read-acc_b_creds"]
  description = "Secrets policy name"
}

## GITHUB JWT/OIDC
variable "enabled_gh_jwt_backend" {
  type        = bool
  description = "Enable GitHub JWT Auth Method or not"
}

variable "gh_jwt_path" {
  type        = string
  default     = "github"
  description = "GitHub JWT Authentication path"
}

variable "default_ttl_gh_jwt" {
  type        = string
  default     = "1h"
  description = "Default Time To Live"
}

variable "max_ttl_gh_jwt" {
  type        = string
  default     = "2h"
  description = "Maximum Time To Live"
}

variable "gh_jwt_token_type" {
  type        = string
  default     = "service"
  description = "`service` token or `batch` token? Default is `service` token"
}

variable "create_gh_acc_role" {
  type        = bool
  description = "Enable Account Role for GitHub JWT Auth Method"
}

variable "gh_acc_bound_claims" {
  type = map(object({
    role_name     = string
    bound_claims  = optional(map(string))
    token_ttl     = number
    token_max_ttl = number
  }))
  default = {
    "key1" = {
      bound_claims = {
        "" = ""
      }
      role_name     = "value"
      token_ttl     = 300
      token_max_ttl = 600
    }
  }
  description = "https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#understanding-the-oidc-token"
}

variable "gh_acc_token_policies" {
  type = list(string)
  default = [
    "default"
  ]
  description = "Policy name to read `Secrets` in path"
}

variable "gh_bound_aud" {
  type        = list(string)
  default     = [""]
  description = "URL of the repository owner, eg: `https://github.com/OWNER`, such as the organization that owns the repository. This is the only claim that can be customized"
}

variable "gh_bound_sub" {
  type        = string
  default     = ""
  description = "Defines the subject claim that is to be validated by the cloud provider"
}