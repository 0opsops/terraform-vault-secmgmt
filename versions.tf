terraform {
  required_version = ">= v1.1.8"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.12.0"
    }
  }
}
