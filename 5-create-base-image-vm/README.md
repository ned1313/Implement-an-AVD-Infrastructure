# Steps to use this config

Update the `terraform.tfvars` file with the poolSubnet ID from the `1-create-domain-controller` deployment. Add values for the location and vm admin username if desired.

Set the password for the vm by exporting an environment variable with the desired value:

```bash
export TF_VAR_vmadmin_password=YOUR_DESIRED_PASSWORD
```

```PowerShell
$env:TF_VAR_vmadmin_password="YOUR_DESIRED_PASSWORD"
```

Then run through the standard Terraform process:

```bash
terraform init
terraform apply
```