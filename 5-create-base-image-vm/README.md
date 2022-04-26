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

# After deploy

Once the Azure VM exists, you can customize it as needed through an RDP session. When you're done, simply run sysprep from the %windir%\sysprep directory and choose an out of box experience (OOBE) and to shut down the VM when complete. 

Then you can use the image capture process to create a managed image. The process will generalize your Azure VM and make it unusable. You can run a `terraform destroy` when the capture is complete to remove all these resources from your account.