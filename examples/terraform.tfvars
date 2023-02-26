region = "us-east-1"

# KV VERSION 2
vault_addr = "https://myvault.com"
token      = "hvs.asdfasdASDFASDFZXCV"



## KV VERSION 2 SECRETS
create_kv_engine = true
kv_v2_path       = "infrastructure"
create_kv_v2     = true
kv_v2 = {
  "qa" = {
    sub_path            = "qa/network"
    disable_read        = true
    delete_all_versions = true
    data_json           = <<EOF
      {
      "availability_zones": [
          "us-east-1a",
          "us-east-1b",
          "us-east-1c"
      ],
      "aws_region": "us-east-1",
      "create_database_internet_gateway_route": true,
      "create_database_subnet_group": true,
      "create_database_subnet_route_table": true,
      "database_subnets": [
          "10.0.144.0/20",
          "10.0.160.0/20",
          "10.0.176.0/20"
      ],
      "elasticache_subnets": [
          "10.0.96.0/20",
          "10.0.112.0/20",
          "10.0.128.0/20"
      ],
      "environment": "qa",
      "private_subnets": [
          "10.0.48.0/20",
          "10.0.64.0/20",
          "10.0.80.0/20"
      ],
      "public_subnets": [
          "10.0.0.0/20",
          "10.0.16.0/20",
          "10.0.32.0/20"
      ],
      "vpc_cidr": "10.0.0.0/16",
      "vpc_name": "env-qa"
      }
    EOF
  },
  "uat" = {
    path                = "uat/network"
    disable_read        = true
    delete_all_versions = true
    data_json           = <<EOF
      {
      "availability_zones": [
          "us-east-1a",
          "us-east-1b",
          "us-east-1c"
      ],
      "aws_region": "us-east-1",
      "create_database_internet_gateway_route": true,
      "create_database_subnet_group": true,
      "create_database_subnet_route_table": true,
      "database_subnets": [
          "192.168.144.0/20",
          "192.168.160.0/20",
          "192.168.176.0/20"
      ],
      "elasticache_subnets": [
          "192.168.96.0/20",
          "192.168.112.0/20",
          "192.168.128.0/20"
      ],
      "environment": "uat",
      "private_subnets": [
          "192.168.48.0/20",
          "192.168.64.0/20",
          "192.168.80.0/20"
      ],
      "public_subnets": [
          "192.168.0.0/20",
          "192.168.16.0/20",
          "192.168.32.0/20"
      ],
      "vpc_cidr": "192.168.0.0/16",
      "vpc_name": "env-uat"
      }
    EOF
  }
}

## VAULT POLICY
create_policy = true
vault_policy = {
  "qa" = {
    name   = "qa-network-read"
    policy = <<EOF
      ## Policy for only reading QA secret values
      path "qa/data/*"
      {
          capabilities = ["read"]
      }
    EOF
  },
  "uat" = {
    name   = "uat-network-read"
    policy = <<EOF
      ## Policy for only reading UAT secret values
      path "uat/data/*"
      {
          capabilities = ["read"]
      }
    EOF
  },
  "account_b" = {
    name   = "account_b"
    policy = <<EOF
      ## Policy for only reading AWS CREDS
      path "aws/creds/account_b"
      {
          capabilities = ["read"]
      }
    EOF
  },
  "reader" = {
    name   = "reader"
    policy = <<EOF
      ## Reader Policy
      path "*"
      {
        capabilities = ["read","list"]
      }
    EOF
  },
  "admin" = {
    name   = "admin"
    policy = <<EOF
      ## Policy for only reading operations tfvars
      path "*"
      {
        capabilities = ["create", "read", "update", "delete", "list", "sudo"]
      }
    EOF
  }
}



## USERPASS
create_userpass = true
users_path = { # will create 2 users authenticating vault
  "user" = {
    data_json = <<EOT
      {
        "policies": ["reader"],
        "password": "reader"
      }
    EOT
    path      = "auth/userpass/users/reader"
  },
  "user2" = {
    data_json = <<EOT
      {
        "policies": ["admin"],
        "password": "admin"
      }
    EOT
    path      = "auth/userpass/users/admin"
  }
}



## ASSUMED_ROLE USER
access_key                = "KOASDJFKASERKLAJEASDF"
secret_key                = "ASDFASzxcvfasrefawetafweaASDFAE"
create_aws_auth_backend   = true
aws_auth_path             = "aws"
create_aws_secret_backend = true
aws_secret_path           = "aws"
create_auth_backend_role  = true
auth_backend_role = {
  "qa" = {
    account_id = "987872910985"
    sts_role   = "arn:aws:iam::987872910985:role/automation-role"
  },
  "uat" = {
    account_id = "342412085405"
    sts_role   = "arn:aws:iam::342412085405:role/automation-role"
  },
}
create_secret_backend_role = true
secret_backend_role = {
  "qa" = {
    name      = "qa"
    role_arns = ["arn:aws:iam::987872910985:role/automation-role"]
  },
  "uat" = {
    name      = "uat"
    role_arns = ["arn:aws:iam::342412085405:role/automation-role"]
  },
}
credential_type = "assumed_role"




## AWS IAM USER
access_key_user                = "ASDFASDFGSHDASDFAS?ERF"
secret_key_user                = "asdfasda4afsefaw4awefaXEfaASDF"
create_aws_auth_backend_user   = true
aws_auth_path_user             = "account_b"
create_aws_secret_backend_user = true
aws_secret_path_user           = "account_b"
create_auth_backend_role_user  = true
auth_backend_role_user = {
  "acc_b" = {
    account_id = "967438773069"
    sts_role   = "arn:aws:iam::967438773069:role/automation-role"
  }
}
create_secret_backend_role_user = true
secret_backend_role_user = {
  "ec2-user" = {
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
credential_type_user = "iam_user"
region_user          = "us-east-1"



## GITLAB JWT/OIDC
enabled_gl_jwt_backend = true
gl_jwt_path            = "jwt"
bound_issuer           = "gitlab.com"
gl_jwt_token_type      = "service"

create_acc_role = true
acc_bound_claims = {
  "qa" = {
    role_name = "qa"
    bound_claims = {
      "project_id" = "23125321"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  }
  "uat" = {
    role_name = "uat"
    bound_claims = {
      "project_id" = "34495162"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  }
}
acc_token_policies = [
  "account_b"
]

create_secret_role = true
secret_bound_claims = {
  "uat-network-read" = {
    role_name = "uat-network-read"
    bound_claims = {
      "project_id" = "34495162"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  },
  "qa-network-read" = {
    role_name = "qa-network-read"
    bound_claims = {
      "project_id" = "23125321"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  }
}
secret_token_policies = [
  "qa",
  "uat"
]


## GITHUB JWT/OIDC
enabled_gh_jwt_backend = true
gh_jwt_path            = "actions"
gh_jwt_token_type      = "batch"

create_gh_acc_role = true
gh_acc_bound_claims = {
  "key1" = {
    bound_claims = {
      "" = ""
    }
    role_name     = "value"
    token_ttl     = 300
    token_max_ttl = 600
  }
}

gh_acc_token_policies = ["default"]
gh_bound_aud          = ["https://github.com/0opsops"]