variable "vault_addr" {
  type        = string
  default     = ""
  description = "Vault url"
}

variable "token" {
  type        = string
  default     = ""
  description = "Token to manage Vault"
}

## KV VERSION 2 SECRETS
variable "create_kv_engine" {
  type        = bool
  default     = false
  description = "Enable KV-V2 secret engine path"
}

variable "kv_v2_path" {
  type        = string
  default     = "infra"
  description = "KV-V2 secret engine path"
}

variable "create_kv_v2" {
  type        = bool
  default     = true
  description = "Enable Generic Secrets or not"
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
      sub_path            = "default1/network2"
      disable_read        = false
      delete_all_versions = false
      data_json           = <<EOF
      { "key1" : "value1" }
      EOF
    },
    "key2" = {
      sub_path            = "default2/network2"
      disable_read        = false
      delete_all_versions = false
      data_json           = <<EOF
      { "key2" : "value2" }
      EOF
    }
  }
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


## VAULT POLICY
variable "create_policy" {
  type        = bool
  default     = true
  description = "Enable Vault policy or not"
}

variable "vault_policy" {
  type = map(object({
    name   = string
    policy = any
  }))
  default = {
    "qa" = {
      name   = "network-read-qa"
      policy = <<EOF
      ## Policy for only reading QA secret values
      path "default/data/qa/*"
      {
          capabilities = ["read"]
      }
      EOF
    },
    "uat" = {
      name   = "network-read-uat"
      policy = <<EOF
      ## Policy for only reading UAT secret values
      path "default/data/uat/*"
      {
          capabilities = ["read"]
      }
      EOF
    }
  }
  description = "Policy to read Secrets in specific path"
}



## VAULT USERPASS
variable "create_userpass" {
  default     = false
  type        = bool
  description = "Authenticate with Username/Password"
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
variable "access_key" {
  default     = ""
  type        = string
  description = "AWS access key of Assumed role user"
}

variable "secret_key" {
  default     = ""
  type        = string
  description = "AWS secret key of Assumed role user"
}

variable "create_aws_auth_backend" {
  default     = false
  type        = bool
  description = "Enable AWS Auth method or not in Vault"
}

variable "create_aws_secret_backend" {
  default     = false
  type        = bool
  description = "Enable AWS Secret Method or not in Vault"
}

variable "default_ttl_aws" {
  type        = number
  default     = 2700
  description = "Default Time To Live for Assumed role"
}

variable "max_ttl_aws" {
  type        = number
  default     = 3600
  description = "Maximum Time To Live for Assumed role"
}

variable "aws_auth_path" {
  type        = string
  default     = ""
  description = "AWS Authentication Methods path"
}

variable "aws_secret_path" {
  type        = string
  default     = ""
  description = "AWS Secret Engine path for Assumed Role"
}

variable "create_auth_backend_role" {
  type        = bool
  default     = true
  description = "Enable STS role or not for Vault"
}

variable "auth_backend_role" { # If enabled, Role that is used by Vault authenticating AWS!
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  default = {
    "ops" = {
      account_id = 123123123123
      sts_role   = "arn:aws:iam::123123123123:role/automation-role"
    },
    "qa" = {
      account_id = 234234234234
      sts_role   = "arn:aws:iam::234234234234:role/automation-role"
    }
  }
  description = "Role that will be used by Vault authenticating AWS"
}

variable "create_secret_backend_role" {
  type        = bool
  default     = true
  description = "Enable a role on an AWS Secret Method or not for Vault"
}

variable "secret_backend_role" {
  type = map(object({
    name      = string
    role_arns = list(string)
  }))
  default = {
    "ops" = {
      name      = "ops"
      role_arns = ["arn:aws:iam::53332291231:role/automation-role"]
    },
    "qa" = {
      name      = "qa"
      role_arns = ["arn:aws:iam::328690889605:role/automation-role"]
    }
  }
  description = "If enabled, Create and use STS Assumed Role by Vault performing necessary actions respectively"
}

variable "credential_type" {
  type        = string
  default     = "assumed_role"
  description = "AWS STS Assumed Role type"
}

variable "region" {
  default     = "us-east-1"
  type        = string
  description = "Region that Vault residing"
}



## AWS IAM User
variable "access_key_user" {
  type        = string
  default     = ""
  description = "AWS access key"
}

variable "secret_key_user" {
  type        = string
  default     = ""
  description = "AWS secrert key"
}

variable "create_aws_auth_backend_user" {
  type        = bool
  default     = true
  description = "Enable AWS Auth method or not"
}

variable "create_aws_secret_backend_user" {
  type        = bool
  default     = false
  description = "Enable AWS Secret Method or not for Vault"
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

variable "aws_auth_path_user" {
  type        = string
  default     = "account_b"
  description = "AWS Authentication Methods path"
}

variable "aws_secret_path_user" {
  type        = string
  default     = ""
  description = "AWS Secret engine path for IAM User"
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
    "acc_b" = {
      account_id = 123123123123
      sts_role   = "arn:aws:iam::123123123123:role/automation-role"
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
    "ec2" = {
      name            = "ec2-user"
      policy_document = <<EOT
        {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
            }
        ]
        }
      EOT
    }
  }
  description = "IAM User with defined IAM permission policy"
}

variable "credential_type_user" {
  default     = "iam_user"
  type        = string
  description = "AWS IAM User type"
}

variable "region_user" {
  default     = "us-east-1"
  type        = string
  description = "Region that Vault residing"
}



## GITLAB JWT/OIDC
variable "enabled_gl_jwt_backend" {
  type        = bool
  default     = false
  description = "Enable JWT Auth Method or not"
}

variable "gl_jwt_path" {
  type        = string
  default     = "jwt"
  description = "JWT Authentication path"
}

variable "bound_issuer" {
  type        = string
  default     = "gitlab.com"
  description = "The value against which to match the iss claim in a JWT"
}

variable "default_ttl_gl_jwt" {
  type        = string
  default     = "60m"
  description = "Default Time To Live"
}

variable "max_ttl_gl_jwt" {
  type        = string
  default     = "120m"
  description = "Maximum Time To Live"
}

variable "gl_jwt_token_type" {
  type        = string
  default     = "service"
  description = "`service` token or `batch` token? Default is `service` token"
}

variable "create_gl_acc_role" {
  type        = bool
  default     = false
  description = "Enable Account Role for GitLab JWT Auth Method"
}

variable "gl_acc_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  default = {
    "key" = {
      bound_claims = {
        "key" = "value"
      }
      role_name = "value"
    }
  }
  description = "JWT/OIDC auth Method role for AWS Account in a Vault server"
}

variable "gl_acc_token_policies" {
  type = list(string)
  default = [
    "ops",
    "qa"
  ]
  description = "Vault policy name to attach on AWS Auth Method Role"
}

variable "create_gl_secret_role" {
  type        = bool
  default     = false
  description = "For GitLab, Enable Secrets JWT Auth Method Role or not"
}

variable "gl_secret_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  default = {
    "key" = {
      bound_claims = {
        "key" = "value"
      }
      role_name = "value"
    }
  }
  description = "JWT/OIDC auth Method role for Secrets values in a Vault server"
}

variable "gl_secret_token_policies" {
  type = list(string)
  default = [
    "ops",
    "qa"
  ]
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
  description = "Vault policy name to attach on AWS Auth Method Role"
}

variable "gh_acc_bound_aud" {
  type        = list(string)
  default     = ["https://github.com/OWNER"]
  description = "URL of the repository owner, such as the organization that owns the repository. This is the only claim that can be customized"
}

variable "gh_acc_bound_sub" {
  type        = optional(string)
  default     = ""
  description = "Defines the subject claim that is to be validated by the cloud provider"
}

variable "create_gh_secret_role" {
  type        = bool
  description = "For GHA, Enable Secrets JWT Auth Method Role or not"
}

variable "gh_secret_bound_claims" {
  type = map(object({
    role_name     = string
    bound_claims  = optional(map(string))
    token_ttl     = number
    token_max_ttl = number
  }))
  default = {
    "key" = {
      bound_claims = {
        "" = ""
      }
      role_name     = "value"
      token_ttl     = 3600
      token_max_ttl = 7200
    }
  }
  description = "JWT/OIDC auth Method role for Secrets values in a Vault server"
}

variable "gh_secret_token_policies" {
  type        = list(string)
  default     = ["default"]
  description = "Secrets policy name"
}

variable "gh_secret_bound_aud" {
  type        = list(string)
  default     = [""]
  description = "URL of the repository owner, eg: `https://github.com/OWNER`, such as the organization that owns the repository. This is the only claim that can be customized"
}

variable "gh_secret_bound_sub" {
  type        = string
  default     = ""
  description = "Defines the subject claim that is to be validated by the cloud provider"
}
