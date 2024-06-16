region = "us-east-1"

# KV VERSION 2
vault_addr = "http://127.0.0.1:8200"
token      = "root"



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
  }
}

## VAULT POLICY
create_policy = true
vault_policy = {
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
create_aws_auth_backend   = false
aws_auth_path             = "aws"
create_aws_secret_backend = false
aws_secret_path           = "aws"
create_auth_backend_role  = false
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
create_secret_backend_role = false
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
create_aws_auth_backend_user   = false
aws_auth_path_user             = "account_b"
create_aws_secret_backend_user = false
aws_secret_path_user           = "account_b"
create_auth_backend_role_user  = false
auth_backend_role_user = {
  "acc_b" = {
    account_id = "967438773069"
    sts_role   = "arn:aws:iam::967438773069:role/automation-role"
  }
}
create_secret_backend_role_user = false
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
enabled_gl_jwt_backend = false
gl_jwt_path            = "jwt"
bound_issuer           = "gitlab.com"
gl_jwt_token_type      = "service"

create_gl_acc_role = false
gl_acc_bound_claims = {
  "qa" = {
    role_name = "qa"
    bound_claims = {
      "project_id" = "23125321"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
    bound_claims_type = "glob"
  }
  "uat" = {
    role_name = "uat"
    bound_claims = {
      "project_id" = "34495162"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
    bound_claims_type = "glob"
  }
}
gl_acc_token_policies = [
  "account_b"
]

create_gl_secret_role = false
gl_secret_bound_claims = {
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
gl_secret_token_policies = [
  "qa",
  "uat"
]




## GITHUB JWT/OIDC
enabled_gh_jwt_backend = false
gh_jwt_path            = "actions"
gh_jwt_token_type      = "batch"

create_gh_acc_role = false
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
gh_acc_bound_aud      = ["https://github.com/0opsops"]
create_gh_secret_role = false




## KUBERNETES
create_k8s = true
k8s_path = {
  "local-k8s" = {
    path = "local-k8s"
  }
}
k8s_role = {
  "local-k8s" = {
    role_name                        = "local-k8s"
    backend                          = "local-k8s"
    bound_service_account_names      = ["vault-auth"]
    bound_service_account_namespaces = ["default"]
    token_policies                   = ["admin"]
    token_ttl_k8s                    = 1800
  }
}
k8s_config = {
  "local-k8s" = {
    backend            = "local-k8s"
    kubernetes_host    = "https://10.200.0.1:443"                                                                     # Replace                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        # K8S_CLUSTER_ENDPOINT OR PROXY_ENDPOINT
    kubernetes_ca_cert = "-----BEGIN CERTIFICATE-----\nASDFQWERQWERASDF\nASDQ@#RDFADFASDF\n-----END CERTIFICATE-----" # Replace # SERVER_CA.crt [k config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 -d]
    token_reviewer_jwt = "eyJhbGciOASDlvcmVLWcifQ.eyJaadlskjfafDSHskdjfalsdkfjlkafasdfasdf.orasdasf"                  # Replace # SERVICE_ACCOUNT_TOKEN [k get secrets sa-secret -o go-template='{{.data.token}}' | base64 -d]
    issuer             = "https://kubernetes.default.svc.cluster.local"
  }
}



## OIDC
enabled_oidc_backend = true
oidc_auth_path = {
  "gmail" = {
    oidc_path          = "oidc"
    oidc_role          = "gmail"
    oidc_discovery_url = "https://accounts.google.com"
    oidc_client_id     = "123456789012-5k3hfs5kvc1h82kjkar895ir6118io4bra8q.apps.googleusercontent.com" # Replace
    oidc_client_sec    = "ASDFDF-xRG_MCY1Ulkr8Ke0cBU87yr_XDKR"                                          # Replace
  }
}
oidc_backend_role = {
  "gmail" = {
    oidc_role_name  = "gmail"
    oidc_user_claim = "sub"
    oidc_token_type = "service"
    oidc_scopes     = [""]
    allowed_redirect_uris = [
      "http://127.0.0.1:8250/oidc/callback",
      "http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback"
    ]
    oidc_token_policies = ["admin"]
  }
}
oidc_identity_group = {
  "gmail" = {
    oidc_identity_group_name     = "gmail"
    oidc_identity_type           = "external"
    oidc_identity_group_policies = ["admin"]
    tags = {
      "Organization" = "OSS"
      "Environs"     = "Georgia"
    }
  }
}
oidc_alias = {
  "gmail" = {
    group_alias_name = "gmail"
  }
}
