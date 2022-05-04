# Initialize terraform
terraform init

# Get values from the hub network deployment
$env:TF_VAR_hub_vnet_name = terraform -chdir="..\1-create-domain-controller" output -raw vnet_name
$env:TF_VAR_hub_vnet_id = terraform -chdir="..\1-create-domain-controller" output -raw vnet_id
$env:TF_VAR_hub_vnet_resource_group = terraform -chdir="..\1-create-domain-controller" output -raw vnet_resource_group
$env:TF_VAR_dc_private_ip_address = terraform -chdir="..\1-create-domain-controller" output -raw dc_private_ip_address
$env:TF_VAR_session_host_domain = terraform -chdir="..\1-create-domain-controller" output -raw dc_domain

$env:TF_VAR_session_host_admin_username = "avdAdmin"
$env:TF_VAR_session_host_admin_password = "Z67f643rpwQh7KIY4aiCju0w"
$env:TF_VAR_session_host_domainuser = "avdDCAdmin@contosohq.xyz"
$env:TF_VAR_session_host_domainpassword = "Z67f643rpwQh7KIY4aiCju0w"
$env:TF_VAR_session_host_oupath = "OU=Contoso Computers,DC=contosohq,DC=xyz"


# Run terraform apply to create the spoke network and peering connection
terraform apply -auto-approve