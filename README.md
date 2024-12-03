# Deploy an AWS S3 Bucket and DynamoDB Table for terraform remote state via Terraform


[![Github Actions](https://github.com/Sanim16/terraform_state/actions/workflows/infra.yml/badge.svg)](https://github.com/Sanim16/terraform_state/actions/workflows/infra.yml)

>This is a Terraform project that deploys an S3 Bucket and a DynamoDB Table for use with my terraform remote state files and for backend management.

>Add a github actions workflow for automation

## Technologies:
- Hashicorp Terraform
- AWS S3
- AWS Dynamodb


## Tasks:

- Get access id, secret id from AWS and ensure user has enough permissions to create infrastructure
- Run the following commands
```
terraform init
terraform plan
terraform apply
```
- Uncomment the backend block in provider.tf and rerun the above commands again. This changes the backend from local to remote and uses the newly created S3 bucket and Dynamodb table

