# Steps to use this config

Set the password for the vm by exporting an environment variable with the desired value:

```bash
export TF_VAR_vmadmin_password=YOUR_DESIRED_PASSWORD
```

```PowerShell
$env:TF_VAR_vmadmin_password="Z67f643rpwQh7KIY4aiCju0w"
```

Then run through the standard Terraform process:

```bash
terraform init
terraform apply
```

If you don't see a public IP address after the run completes, simply run this command:

```bash
terraform apply -refresh-only -auto-approve
```

# After deploy

Once the Azure VM exists, you can customize it as needed through an RDP session. When you're done, simply run sysprep from the %windir%\sysprep directory and choose an out of box experience (OOBE) and to shut down the VM when complete. 

Then you can use the image capture process to create a managed image. The process will generalize your Azure VM and make it unusable. You can run a `terraform destroy` when the capture is complete to remove all these resources from your account.