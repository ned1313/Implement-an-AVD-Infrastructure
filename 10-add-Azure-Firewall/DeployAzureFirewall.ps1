# This script will add the following resources to the project:
# - An Azure Firewall instance in the hub network
# - An Azure Firewall policy
# - An Azure Firewall rule collection group
# - A route table

# You will need to assign subnets to the route table to allow the firewall to work.

# The Azure Firewall is expensive to run ($1.25/hour) so I recommend removing it once you
# are done experimenting with it.

# Initialize terraform
terraform init

# Set the Subnet ID for the Azure Firewall
# You can get the Subnet ID from the terraform output in the first directory
$subnets = terraform -chdir="..\1-create-domain-controller" output -json subnets | ConvertFrom-Json
$env:TF_VAR_fw_subnet_id = $subnets.AzureFirewallSubnet

# Get the resource group for the Hub VNet
$env:TF_VAR_hub_vnet_resource_group = terraform -chdir="..\1-create-domain-controller" output -raw vnet_resource_group

# Set up the Firewall
terraform apply -auto-approve

# Remove the Azure Firewall when you're done
# You'll need to remove any extra rules you added and subnet route assignments first
terraform destroy