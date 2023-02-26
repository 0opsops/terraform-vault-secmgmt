terraform {
  required_version = ">= v1.3.9"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.12.0"
    }
  }
}
