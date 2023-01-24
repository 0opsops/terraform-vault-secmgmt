# Managing HashiCorp Vault Secrets

## Multi AWS account `assumed_role` and Generating `IAM Users` for CI/CD purpose on the top of pre-existing Vault!

### Auth Methods

- AWS
- JWT
- USERPASS

### Secrets Engines

- KV-V2
- AWS

## THIS MODULE DOWNSIDE IS ALL SECRETS VALUES WOULD BE INSIDE `TERRAFORM.TFVARS` THAT AIN'T PRETTY GOOD AND REALLY HARD MANAGING SECRETS IN LARGE SCALE!

________________________________________________________________

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= v1.1.8 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 3.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_auth_backend.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_auth_backend.user](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_auth_backend.userpass](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_aws_auth_backend_sts_role.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_auth_backend_sts_role) | resource |
| [vault_aws_auth_backend_sts_role.user](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_auth_backend_sts_role) | resource |
| [vault_aws_secret_backend.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend) | resource |
| [vault_aws_secret_backend.user](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend) | resource |
| [vault_aws_secret_backend_role.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.user](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_generic_endpoint.users](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_endpoint) | resource |
| [vault_jwt_auth_backend.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.account](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_kv_secret_v2.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_mount.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acc_bound_claims"></a> [acc\_bound\_claims](#input\_acc\_bound\_claims) | JWT/OIDC auth backend role for AWS Account in a Vault server | <pre>map(object({<br>    role_name    = string<br>    bound_claims = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_acc_token_policies"></a> [acc\_token\_policies](#input\_acc\_token\_policies) | AWS Accounts policy name | `list(string)` | n/a | yes |
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | AWS Assumed Role access key | `string` | n/a | yes |
| <a name="input_access_key_user"></a> [access\_key\_user](#input\_access\_key\_user) | AWS access key | `string` | n/a | yes |
| <a name="input_auth_backend_role"></a> [auth\_backend\_role](#input\_auth\_backend\_role) | Role that will be used by Vault authenticating AWS | <pre>map(object({<br>    account_id = number<br>    sts_role   = string<br>  }))</pre> | n/a | yes |
| <a name="input_auth_backend_role_user"></a> [auth\_backend\_role\_user](#input\_auth\_backend\_role\_user) | If enabled, This Role that will be used by Vault authenticating and performing necessary actions | <pre>map(object({<br>    account_id = number<br>    sts_role   = string<br>  }))</pre> | n/a | yes |
| <a name="input_aws_auth_path"></a> [aws\_auth\_path](#input\_aws\_auth\_path) | AWS Authentication Methods path | `string` | n/a | yes |
| <a name="input_aws_auth_path_user"></a> [aws\_auth\_path\_user](#input\_aws\_auth\_path\_user) | AWS Authentication Methods path | `string` | n/a | yes |
| <a name="input_aws_secret_path"></a> [aws\_secret\_path](#input\_aws\_secret\_path) | AWS Secret Engine path for Assumed Role | `string` | n/a | yes |
| <a name="input_aws_secret_path_user"></a> [aws\_secret\_path\_user](#input\_aws\_secret\_path\_user) | AWS Secret engine path for IAM User | `string` | n/a | yes |
| <a name="input_bound_issuer"></a> [bound\_issuer](#input\_bound\_issuer) | The value against which to match the iss claim in a JWT | `string` | n/a | yes |
| <a name="input_create_acc_role"></a> [create\_acc\_role](#input\_create\_acc\_role) | Enable Account JWT Auth Backend Role or not | `bool` | n/a | yes |
| <a name="input_create_auth_backend_role"></a> [create\_auth\_backend\_role](#input\_create\_auth\_backend\_role) | Enable STS role or not for Vault | `bool` | n/a | yes |
| <a name="input_create_auth_backend_role_user"></a> [create\_auth\_backend\_role\_user](#input\_create\_auth\_backend\_role\_user) | Enable STS role or not on Vault | `bool` | n/a | yes |
| <a name="input_create_aws_auth_backend"></a> [create\_aws\_auth\_backend](#input\_create\_aws\_auth\_backend) | Enable AWS Auth method or not | `bool` | n/a | yes |
| <a name="input_create_aws_auth_backend_user"></a> [create\_aws\_auth\_backend\_user](#input\_create\_aws\_auth\_backend\_user) | Enable AWS Auth method or not | `bool` | `false` | no |
| <a name="input_create_aws_secret_backend"></a> [create\_aws\_secret\_backend](#input\_create\_aws\_secret\_backend) | Enable AWS Secret Backend or not for Vault | `bool` | n/a | yes |
| <a name="input_create_aws_secret_backend_user"></a> [create\_aws\_secret\_backend\_user](#input\_create\_aws\_secret\_backend\_user) | Enable AWS Secret Backend or not for Vault | `bool` | n/a | yes |
| <a name="input_create_kv_v2"></a> [create\_kv\_v2](#input\_create\_kv\_v2) | Enable KV Version 2 Secrets or not | `bool` | n/a | yes |
| <a name="input_create_mountpath"></a> [create\_mountpath](#input\_create\_mountpath) | Enable KV-V2 secret engine path | `bool` | n/a | yes |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Enable Vault policy or not | `bool` | n/a | yes |
| <a name="input_create_secret_backend_role"></a> [create\_secret\_backend\_role](#input\_create\_secret\_backend\_role) | Enable a role on an AWS Secret Backend or not for Vault | `bool` | n/a | yes |
| <a name="input_create_secret_backend_role_user"></a> [create\_secret\_backend\_role\_user](#input\_create\_secret\_backend\_role\_user) | Enable a role on an AWS Secret Backend for Vault | `bool` | n/a | yes |
| <a name="input_create_secret_role"></a> [create\_secret\_role](#input\_create\_secret\_role) | Enable Secrets JWT Auth Backend Role or not | `bool` | n/a | yes |
| <a name="input_create_userpass"></a> [create\_userpass](#input\_create\_userpass) | Authenticate Vault with Username/Password | `bool` | `false` | no |
| <a name="input_credential_type"></a> [credential\_type](#input\_credential\_type) | AWS STS Assumed Role type | `string` | `"assumed_role"` | no |
| <a name="input_credential_type_user"></a> [credential\_type\_user](#input\_credential\_type\_user) | AWS IAM User type | `string` | `"iam_user"` | no |
| <a name="input_default_ttl_aws"></a> [default\_ttl\_aws](#input\_default\_ttl\_aws) | Default Time To Live for Assumed role | `string` | `1800` | no |
| <a name="input_default_ttl_jwt"></a> [default\_ttl\_jwt](#input\_default\_ttl\_jwt) | Default Time To Live | `string` | `"60m"` | no |
| <a name="input_default_ttl_user"></a> [default\_ttl\_user](#input\_default\_ttl\_user) | Default Time To Live | `number` | `2700` | no |
| <a name="input_delete_version_after"></a> [delete\_version\_after](#input\_delete\_version\_after) | Old secrets version will be deleted after this seconds | `number` | `604800` | no |
| <a name="input_enabled_jwt_backend"></a> [enabled\_jwt\_backend](#input\_enabled\_jwt\_backend) | Enable JWT Auth Backend or not | `bool` | n/a | yes |
| <a name="input_jwt_path"></a> [jwt\_path](#input\_jwt\_path) | JWT Authentication path | `string` | n/a | yes |
| <a name="input_kv_v2"></a> [kv\_v2](#input\_kv\_v2) | Key/Value store | <pre>map(object({<br>    sub_path            = string<br>    disable_read        = bool<br>    delete_all_versions = bool<br>    data_json           = any<br>  }))</pre> | n/a | yes |
| <a name="input_max_ttl_aws"></a> [max\_ttl\_aws](#input\_max\_ttl\_aws) | Maximum Time To Live for Assumed role | `string` | `3600` | no |
| <a name="input_max_ttl_jwt"></a> [max\_ttl\_jwt](#input\_max\_ttl\_jwt) | Maximum Time To Live | `string` | `"120m"` | no |
| <a name="input_max_ttl_user"></a> [max\_ttl\_user](#input\_max\_ttl\_user) | Maximum Time To Live | `number` | `3600` | no |
| <a name="input_max_versions"></a> [max\_versions](#input\_max\_versions) | Maximum versions of the secrets | `number` | `100` | no |
| <a name="input_region"></a> [region](#input\_region) | Region that Vault residing | `string` | n/a | yes |
| <a name="input_region_user"></a> [region\_user](#input\_region\_user) | Region that Vault residing | `string` | n/a | yes |
| <a name="input_secret_backend_role"></a> [secret\_backend\_role](#input\_secret\_backend\_role) | Create and use STS Assumed Role by Vault performing necessary actions respectively | <pre>map(object({<br>    name      = string<br>    role_arns = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_secret_backend_role_user"></a> [secret\_backend\_role\_user](#input\_secret\_backend\_role\_user) | IAM User with defined IAM permission policy respectively | <pre>map(object({<br>    name            = string<br>    policy_document = any<br>  }))</pre> | n/a | yes |
| <a name="input_secret_bound_claims"></a> [secret\_bound\_claims](#input\_secret\_bound\_claims) | JWT/OIDC auth backend role for Secrets values in a Vault server | <pre>map(object({<br>    role_name    = string<br>    bound_claims = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | AWS Assumed Role secret key | `string` | n/a | yes |
| <a name="input_secret_key_user"></a> [secret\_key\_user](#input\_secret\_key\_user) | AWS secret key | `string` | n/a | yes |
| <a name="input_secret_token_policies"></a> [secret\_token\_policies](#input\_secret\_token\_policies) | Secrets policy name | `list(string)` | n/a | yes |
| <a name="input_users_path"></a> [users\_path](#input\_users\_path) | n/a | <pre>map(object({<br>    path      = string<br>    data_json = any<br>  }))</pre> | n/a | yes |
| <a name="input_vault_mount"></a> [vault\_mount](#input\_vault\_mount) | KV-V2 secret engine path | <pre>map(object({<br>    path        = string<br>    type        = string<br>    description = string<br>  }))</pre> | n/a | yes |
| <a name="input_vault_policy"></a> [vault\_policy](#input\_vault\_policy) | Policy to read secret by path | <pre>map(object({<br>    name   = string<br>    policy = any<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
