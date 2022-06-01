# CICD Pipeline

This component is use to create the aws role that the ci/cd pipeline can assume in order to deploy the infrastructure via terraform


## Deployment

The infrastructure for the role and permissions are deployed using terraform.

The terraform deployment is done manually e.g via terraform cli

```sh
terraform init
terraform plan
terraform apply -auto-approve
```
