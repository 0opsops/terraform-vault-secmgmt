# Managing HashiCorp Vault Secrets with **Terraform**

## Multi AWS accounts `assumed_role` and Generating `IAM Users` for CI/CD purpose on the top of pre-existing Vault!
## [Just like this!](https://github.com/0opsops/terraform-vault-secmgmt/tree/main/examples#in-account-b-create-a-role-called-automation-role-with-necessary-permission-policy-attached)

### Auth Methods

- AWS
- JWT (GitLab, GitHub)
- USERPASS

### Secrets Engines

- KV-V2
- AWS

## THIS MODULE DOWNSIDE IS ALL SECRETS VALUES WOULD BE INSIDE `TERRAFORM.TFVARS` THAT AIN'T PRETTY GOOD AND REALLY HARD MANAGING SECRETS IN LARGE SCALE!

________________________________________________________________

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= v1.3.9 |
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
| [vault_jwt_auth_backend.gh](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.account](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.actions](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.actions_sec](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_kv_secret_v2.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_mount.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | AWS Assumed Role access key | `string` | `"ACCESS_KEY"` | no |
| <a name="input_access_key_user"></a> [access\_key\_user](#input\_access\_key\_user) | AWS Access Key with necessary permissions | `string` | `"ACCESS_KEY"` | no |
| <a name="input_auth_backend_role"></a> [auth\_backend\_role](#input\_auth\_backend\_role) | Role that will be used by Vault authenticating AWS | <pre>map(object({<br>    account_id = number<br>    sts_role   = string<br>  }))</pre> | <pre>{<br>  "key": {<br>    "account_id": 123456789012,<br>    "sts_role": "arn:aws:iam::123456789012:role/ROLE_NAME"<br>  }<br>}</pre> | no |
| <a name="input_auth_backend_role_user"></a> [auth\_backend\_role\_user](#input\_auth\_backend\_role\_user) | If enabled, This Role that will be used by Vault authenticating and performing necessary actions | <pre>map(object({<br>    account_id = number<br>    sts_role   = string<br>  }))</pre> | <pre>{<br>  "key": {<br>    "account_id": 13456789012,<br>    "sts_role": "value"<br>  }<br>}</pre> | no |
| <a name="input_aws_auth_path"></a> [aws\_auth\_path](#input\_aws\_auth\_path) | AWS Authentication Methods path | `string` | `"aws"` | no |
| <a name="input_aws_auth_path_user"></a> [aws\_auth\_path\_user](#input\_aws\_auth\_path\_user) | AWS IAM user Authentication Methods path | `string` | `"account_b"` | no |
| <a name="input_aws_secret_path"></a> [aws\_secret\_path](#input\_aws\_secret\_path) | AWS Secret Engine path for Assumed Role | `string` | `"aws"` | no |
| <a name="input_aws_secret_path_user"></a> [aws\_secret\_path\_user](#input\_aws\_secret\_path\_user) | AWS Secret engine path for IAM User | `string` | `"account_b"` | no |
| <a name="input_bound_issuer"></a> [bound\_issuer](#input\_bound\_issuer) | The value against which to match the iss claim in a JWT | `string` | `"gitlab.com"` | no |
| <a name="input_create_auth_backend_role"></a> [create\_auth\_backend\_role](#input\_create\_auth\_backend\_role) | Enable STS role or not for Vault | `bool` | `false` | no |
| <a name="input_create_auth_backend_role_user"></a> [create\_auth\_backend\_role\_user](#input\_create\_auth\_backend\_role\_user) | Enable STS role or not on Vault | `bool` | `false` | no |
| <a name="input_create_aws_auth_backend"></a> [create\_aws\_auth\_backend](#input\_create\_aws\_auth\_backend) | Enable AWS Auth method or not | `bool` | n/a | yes |
| <a name="input_create_aws_auth_backend_user"></a> [create\_aws\_auth\_backend\_user](#input\_create\_aws\_auth\_backend\_user) | Enable AWS Auth method or not | `bool` | n/a | yes |
| <a name="input_create_aws_secret_backend"></a> [create\_aws\_secret\_backend](#input\_create\_aws\_secret\_backend) | Enable AWS Secret Method or not for Vault | `bool` | `false` | no |
| <a name="input_create_aws_secret_backend_user"></a> [create\_aws\_secret\_backend\_user](#input\_create\_aws\_secret\_backend\_user) | Vault Enable AWS Secret Method or not | `bool` | `false` | no |
| <a name="input_create_gh_acc_role"></a> [create\_gh\_acc\_role](#input\_create\_gh\_acc\_role) | Enable Account Role for GitHub JWT Auth Method | `bool` | n/a | yes |
| <a name="input_create_gh_secret_role"></a> [create\_gh\_secret\_role](#input\_create\_gh\_secret\_role) | For GHA, Enable Secrets JWT Auth Method Role or not | `bool` | n/a | yes |
| <a name="input_create_gl_acc_role"></a> [create\_gl\_acc\_role](#input\_create\_gl\_acc\_role) | Enable Account Role for GitHub JWT Auth Method | `bool` | n/a | yes |
| <a name="input_create_gl_secret_role"></a> [create\_gl\_secret\_role](#input\_create\_gl\_secret\_role) | For GitLab, Enable Secrets JWT Auth Method Role or not | `bool` | n/a | yes |
| <a name="input_create_kv_engine"></a> [create\_kv\_engine](#input\_create\_kv\_engine) | Enable KV version 2 secret engine | `bool` | n/a | yes |
| <a name="input_create_kv_v2"></a> [create\_kv\_v2](#input\_create\_kv\_v2) | Create KV Version 2 Secrets | `bool` | n/a | yes |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Enable Vault policy or not | `bool` | n/a | yes |
| <a name="input_create_secret_backend_role"></a> [create\_secret\_backend\_role](#input\_create\_secret\_backend\_role) | Enable a role on an AWS Secret Method or not for Vault | `bool` | `false` | no |
| <a name="input_create_secret_backend_role_user"></a> [create\_secret\_backend\_role\_user](#input\_create\_secret\_backend\_role\_user) | Enable a role on an AWS Secret Method for Vault | `bool` | `false` | no |
| <a name="input_create_userpass"></a> [create\_userpass](#input\_create\_userpass) | Authenticate Vault with Username/Password | `bool` | n/a | yes |
| <a name="input_credential_type"></a> [credential\_type](#input\_credential\_type) | AWS STS Assumed Role type | `string` | `"assumed_role"` | no |
| <a name="input_credential_type_user"></a> [credential\_type\_user](#input\_credential\_type\_user) | AWS IAM User type | `string` | `"iam_user"` | no |
| <a name="input_default_ttl_aws"></a> [default\_ttl\_aws](#input\_default\_ttl\_aws) | Default Time To Live for Assumed role | `string` | `1800` | no |
| <a name="input_default_ttl_gh_jwt"></a> [default\_ttl\_gh\_jwt](#input\_default\_ttl\_gh\_jwt) | Default Time To Live | `string` | `"1h"` | no |
| <a name="input_default_ttl_gl_jwt"></a> [default\_ttl\_gl\_jwt](#input\_default\_ttl\_gl\_jwt) | Default Time To Live | `string` | `"1h"` | no |
| <a name="input_default_ttl_user"></a> [default\_ttl\_user](#input\_default\_ttl\_user) | Default Time To Live for AWS temporary account | `number` | `2700` | no |
| <a name="input_delete_version_after"></a> [delete\_version\_after](#input\_delete\_version\_after) | Old secrets version will be deleted after this seconds (7 days) | `number` | `604800` | no |
| <a name="input_enabled_gh_jwt_backend"></a> [enabled\_gh\_jwt\_backend](#input\_enabled\_gh\_jwt\_backend) | Enable GitHub JWT Auth Method or not | `bool` | n/a | yes |
| <a name="input_enabled_gl_jwt_backend"></a> [enabled\_gl\_jwt\_backend](#input\_enabled\_gl\_jwt\_backend) | Enable GitLab JWT Auth Method or not | `bool` | n/a | yes |
| <a name="input_gh_acc_bound_aud"></a> [gh\_acc\_bound\_aud](#input\_gh\_acc\_bound\_aud) | URL of the repository owner, eg: `https://github.com/OWNER`, such as the organization that owns the repository. This is the only claim that can be customized | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_gh_acc_bound_claims"></a> [gh\_acc\_bound\_claims](#input\_gh\_acc\_bound\_claims) | https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#understanding-the-oidc-token | <pre>map(object({<br>    role_name     = string<br>    bound_claims  = optional(map(string))<br>    token_ttl     = number<br>    token_max_ttl = number<br>  }))</pre> | <pre>{<br>  "key1": {<br>    "bound_claims": {<br>      "": ""<br>    },<br>    "role_name": "value",<br>    "token_max_ttl": 600,<br>    "token_ttl": 300<br>  }<br>}</pre> | no |
| <a name="input_gh_acc_bound_sub"></a> [gh\_acc\_bound\_sub](#input\_gh\_acc\_bound\_sub) | Defines the subject claim that is to be validated by the cloud provider | `string` | `""` | no |
| <a name="input_gh_acc_token_policies"></a> [gh\_acc\_token\_policies](#input\_gh\_acc\_token\_policies) | Vault policy name to attach on AWS Auth Method Role | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_gh_jwt_path"></a> [gh\_jwt\_path](#input\_gh\_jwt\_path) | GitHub JWT Authentication path | `string` | `"jwt-gh"` | no |
| <a name="input_gh_jwt_token_type"></a> [gh\_jwt\_token\_type](#input\_gh\_jwt\_token\_type) | `service` token or `batch` token? Default is `service` token | `string` | `"service"` | no |
| <a name="input_gh_secret_bound_aud"></a> [gh\_secret\_bound\_aud](#input\_gh\_secret\_bound\_aud) | URL of the repository owner, eg: `https://github.com/OWNER`, such as the organization that owns the repository. This is the only claim that can be customized | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_gh_secret_bound_claims"></a> [gh\_secret\_bound\_claims](#input\_gh\_secret\_bound\_claims) | JWT/OIDC auth Method role for Secrets values in a Vault server | <pre>map(object({<br>    role_name     = string<br>    bound_claims  = optional(map(string))<br>    token_ttl     = number<br>    token_max_ttl = number<br>  }))</pre> | <pre>{<br>  "key": {<br>    "bound_claims": {<br>      "": ""<br>    },<br>    "role_name": "value",<br>    "token_max_ttl": 7200,<br>    "token_ttl": 3600<br>  }<br>}</pre> | no |
| <a name="input_gh_secret_bound_sub"></a> [gh\_secret\_bound\_sub](#input\_gh\_secret\_bound\_sub) | Defines the subject claim that is to be validated by the cloud provider | `string` | `""` | no |
| <a name="input_gh_secret_token_policies"></a> [gh\_secret\_token\_policies](#input\_gh\_secret\_token\_policies) | Secrets policy name | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_gl_acc_bound_claims"></a> [gl\_acc\_bound\_claims](#input\_gl\_acc\_bound\_claims) | JWT/OIDC auth Method role for AWS Account in a Vault server | <pre>map(object({<br>    role_name    = string<br>    bound_claims = map(string)<br>  }))</pre> | <pre>{<br>  "key": {<br>    "bound_claims": {<br>      "project_id": "12312312",<br>      "ref": "main,develop",<br>      "ref_type": "branch"<br>    },<br>    "bound_claims_type": "glob",<br>    "role_name": "ROLE_NAME"<br>  }<br>}</pre> | no |
| <a name="input_gl_acc_token_policies"></a> [gl\_acc\_token\_policies](#input\_gl\_acc\_token\_policies) | Vault policy name to attach on AWS Auth Method Role | `list(string)` | <pre>[<br>  "account_b"<br>]</pre> | no |
| <a name="input_gl_jwt_path"></a> [gl\_jwt\_path](#input\_gl\_jwt\_path) | GitLab JWT Authentication path | `string` | `"jwt-gl"` | no |
| <a name="input_gl_jwt_token_type"></a> [gl\_jwt\_token\_type](#input\_gl\_jwt\_token\_type) | `service` token or `batch` token? Default is `service` token | `string` | `"service"` | no |
| <a name="input_gl_secret_bound_claims"></a> [gl\_secret\_bound\_claims](#input\_gl\_secret\_bound\_claims) | JWT/OIDC auth Method role for Secrets values in a Vault server | <pre>map(object({<br>    role_name    = string<br>    bound_claims = map(string)<br>  }))</pre> | <pre>{<br>  "key": {<br>    "bound_claims": {<br>      "project_id": "123123",<br>      "ref": "main,develop",<br>      "ref_type": "branch"<br>    },<br>    "role_name": "reader-role"<br>  }<br>}</pre> | no |
| <a name="input_gl_secret_token_policies"></a> [gl\_secret\_token\_policies](#input\_gl\_secret\_token\_policies) | Secrets policy name | `list(string)` | <pre>[<br>  "read-acc_b_creds"<br>]</pre> | no |
| <a name="input_kv_v2"></a> [kv\_v2](#input\_kv\_v2) | Key/Value store | <pre>map(object({<br>    sub_path            = string<br>    disable_read        = bool<br>    delete_all_versions = bool<br>    data_json           = any<br>  }))</pre> | <pre>{<br>  "key1": {<br>    "data_json": "        {\n          \"key1\": \"value1\"\n        }\n",<br>    "delete_all_versions": true,<br>    "disable_read": false,<br>    "sub_path": "path1"<br>  },<br>  "key2": {<br>    "data_json": "        {\n          \"key2\": \"value2\"\n        }\n",<br>    "delete_all_versions": true,<br>    "disable_read": false,<br>    "sub_path": "path2"<br>  }<br>}</pre> | no |
| <a name="input_kv_v2_description"></a> [kv\_v2\_description](#input\_kv\_v2\_description) | Just a description | `string` | `"Mount path of KV-V2 secret engine"` | no |
| <a name="input_kv_v2_path"></a> [kv\_v2\_path](#input\_kv\_v2\_path) | KV-V2 secret engine path | `string` | `"infra"` | no |
| <a name="input_max_ttl_aws"></a> [max\_ttl\_aws](#input\_max\_ttl\_aws) | Maximum Time To Live for Assumed role | `string` | `3600` | no |
| <a name="input_max_ttl_gh_jwt"></a> [max\_ttl\_gh\_jwt](#input\_max\_ttl\_gh\_jwt) | Maximum Time To Live | `string` | `"2h"` | no |
| <a name="input_max_ttl_gl_jwt"></a> [max\_ttl\_gl\_jwt](#input\_max\_ttl\_gl\_jwt) | Maximum Time To Live | `string` | `"2h"` | no |
| <a name="input_max_ttl_user"></a> [max\_ttl\_user](#input\_max\_ttl\_user) | Maximum Time To Live for AWS temporary account | `number` | `3600` | no |
| <a name="input_max_versions"></a> [max\_versions](#input\_max\_versions) | Maximum versions of the secrets | `number` | `100` | no |
| <a name="input_region"></a> [region](#input\_region) | Region that Vault residing | `string` | `"us-east-1"` | no |
| <a name="input_region_user"></a> [region\_user](#input\_region\_user) | Region that Vault residing | `string` | `"us-east-1"` | no |
| <a name="input_secret_backend_role"></a> [secret\_backend\_role](#input\_secret\_backend\_role) | Create and use STS Assumed Role by Vault performing necessary actions respectively | <pre>map(object({<br>    name      = string<br>    role_arns = list(string)<br>  }))</pre> | <pre>{<br>  "key": {<br>    "name": "aws",<br>    "role_arns": [<br>      "arn:aws:iam::123456789012:role/ROLE_NAME"<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_secret_backend_role_user"></a> [secret\_backend\_role\_user](#input\_secret\_backend\_role\_user) | IAM User with defined IAM permission policy respectively | <pre>map(object({<br>    name            = string<br>    policy_document = any<br>  }))</pre> | <pre>{<br>  "key": {<br>    "name": "value",<br>    "policy_document": {}<br>  }<br>}</pre> | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | AWS Assumed Role User secret key | `string` | `"SECRET_KEY"` | no |
| <a name="input_secret_key_user"></a> [secret\_key\_user](#input\_secret\_key\_user) | AWS Secret Key with necessary permissions | `string` | `"SECRET_KEY"` | no |
| <a name="input_userpass_path"></a> [userpass\_path](#input\_userpass\_path) | Mount path for `Userpass` auth method | `string` | `"userpass"` | no |
| <a name="input_users_path"></a> [users\_path](#input\_users\_path) | The full logical path with `username` suffix | <pre>map(object({<br>    path      = string<br>    data_json = any<br>  }))</pre> | <pre>{<br>  "user1": {<br>    "data_json": "        {\n          \"policies\": [\"POLICY\"],\n          \"password\": \"PASSWORD\"\n        }\n",<br>    "path": "auth/userpass/users/USERNAME"<br>  }<br>}</pre> | no |
| <a name="input_vault_policy"></a> [vault\_policy](#input\_vault\_policy) | Policy to read secret by path | <pre>map(object({<br>    name   = string<br>    policy = any<br>  }))</pre> | <pre>{<br>  "key1": {<br>    "name": "reader",<br>    "policy": "        ## Policy for only reading secrets in this path\n        path \"tfvars/data/*\"\n        {\n            capabilities = [\"read\"]\n        }\n"<br>  }<br>}</pre> | no |

## Outputs

No outputs.
