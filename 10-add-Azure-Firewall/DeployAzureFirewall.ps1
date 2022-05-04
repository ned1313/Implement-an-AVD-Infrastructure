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