# This script will add the following resources to the project:
# - A subnet for the Azure Bastion service in the hub network
# - A public IP address for the Bastion service
# - An Azure Bastion service

# Azure Bastion costs money to have up and running even when you're not using it ($0.19/hour)
# so I recommend removing it once you are done experimenting with it.

# Initialize terraform
terraform init

# Get the resource group and name of the Hub VNet
$env:TF_VAR_hub_vnet_resource_group = terraform -chdir="..\1-create-domain-controller" output -raw vnet_resource_group
$env:TF_VAR_hub_vnet_name = terraform -chdir="..\1-create-domain-controller" output -raw vnet_name

# Set the IP address range for the Bastion subnet
$env:TF_VAR_bastion_subnet_ip_range = "10.0.0.64/26"

# Create the bastion host
terraform apply -auto-approve

# Remove the bastion host when you're done
terraform destroy