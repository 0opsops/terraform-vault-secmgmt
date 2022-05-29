# Terraform Module managing HashiCorp Vault Secrets

## Multi AWS account `assumed_role` and Generating `IAM Users` for CI/CD purpose!

### Auth Backend

- AWS
- JWT

### Secrets Engines

- KV-V2
- AWS

## THIS MODULE DOWNSIDE IS ALL SECRETS VALUES WOULD BE INSIDE `TERRAFORM.TFVARS` THAT AIN'T PRETTY GOOD AND REALLY HARD MANAGING SECRETS IN LARGE SCALE!