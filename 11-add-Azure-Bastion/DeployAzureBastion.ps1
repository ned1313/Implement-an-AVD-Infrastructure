# Initialize terraform
terraform init

# Get the resource group and name of the Hub VNet
$env:TF_VAR_hub_vnet_resource_group = terraform -chdir="..\1-create-domain-controller" output -raw vnet_resource_group
$env:TF_VAR_hub_vnet_name = terraform -chdir="..\1-create-domain-controller" output -raw vnet_name

# Set the IP address range for the Bastion subnet
$env:TF_VAR_bastion_subnet_ip_range = "10.0.0.64/26"

# Create the bastion host
terraform apply -auto-approve