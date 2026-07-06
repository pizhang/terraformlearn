# Lesson 1: Terraform 101

## Providers

This sample project is using fixed version of required version and providers version. This is to immuate production environment, to use fixed version, and test and upgrade if the verions are changed.

## Backend

This sample project is using Terraform Cloud as the backend.

Run the following command to login to HCP Terraform:

```
terraform login
```

## AWS Logon

We have used HCP Terraform workspace "Quick setup AWS dynamic credentials" to create the following IAM role. And added inline permissions manaully.

The following key value sets have been added to HCP Terraform workspace 
variables to allow access to AWS:

Key: TFC_AWS_PROVIDER_AUTH
Value: true

Key: TFC_AWS_RUN_ROLE_ARN
Value: arn:aws:iam::509399591785:role/terraform-pzawslearn
	
Key: TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE
Value: aws.workload.identity	

	

## Usage

```
terraform init
terraform plan
terraform apply
terraform destroy
```



