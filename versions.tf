terraform {
  required_version = ">= v1.6.5"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 4.2.0"
    }
  }
}
