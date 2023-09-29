# CICD Pipeline ACL

This component is use to create the aws role that the ci/cd pipeline can assume in order to deploy the infrastructure

## Development

Create an entry file in the form of `iam-<component>.tf` for each component that needs aws role to assume for deploying infrastructure

## Deployment

The infrastructure for the role and permissions are deployed using terraform.

The terraform deployment is done manually via terraform cli

```sh
cd infrastructure
terraform init
terraform plan -out local.tfplan
terraform apply local.tfplan
```
