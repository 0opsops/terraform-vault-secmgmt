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

## Secrets
variable "create_mountpath" {
  type        = bool
  default     = false
  description = "Enable KV-V2 secret engine path"
}

variable "vault_mount" {
  type = map(object({
    path        = string
    type        = string
    description = string
  }))
  default = {
    "key" = {
      description = "My Secrets"
      path        = "default"
      type        = "kv-v2"
    }
  }
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
    "reader" = {
      path      = "operations"
      data_json = <<EOF
        { "key1" : "value1" }
      EOF
    }
  }
  description = ""
}



## Assumed Role
variable "access_key" {
  default     = ""
  type        = string
  description = "AWS access key"
}

variable "secret_key" {
  default     = ""
  type        = string
  description = "AWS secret key"
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

variable "auth_backend_role" {
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

variable "auth_backend_role_user" { # If enabled, Role that is used by Vault authenticating AWS!
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



## JWT
variable "enabled_jwt_backend" {
  type        = bool
  default     = false
  description = "Enable JWT Auth Method or not"
}

variable "jwt_path" {
  type        = string
  default     = "jwt"
  description = "JWT Authentication path"
}

variable "bound_issuer" {
  type        = string
  default     = "gitlab.com"
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
  default     = false
  description = "Enable Account JWT Auth Method Role or not"
}

variable "acc_bound_claims" {
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

variable "acc_token_policies" {
  type = list(string)
  default = [
    "ops",
    "qa"
  ]
  description = "Accounts policy name"
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
        "key" = "value"
      }
      role_name = "value"
    }
  }
  description = "JWT/OIDC auth Method role for Secrets values in a Vault server"
}

variable "secret_token_policies" {
  type = list(string)
  default = [
    "ops",
    "qa"
  ]
  description = "Secrets policy name"
}
