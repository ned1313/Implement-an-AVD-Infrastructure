# Deploy a host pool for the session host with Terraform
terraform init
terraform apply -auto-approve

# Store the Terraform output for use in the next step
# Get the Registration Token Value
$hostPoolToken = $(terraform output -raw token)

# Set the Resource Group of the Host Pool and name of Host Pool
$resourceGroupName = $(terraform output -raw resource_group_name)
$hostPool = $(terraform output -raw host_pool_name)

# Get credentials for the domain admin and local vmadmin
$domainAdmin = get-credential -Message "Enter domain admin credentials"
$vmAdmin = get-credential -Message "Enter vm admin credentials"

# Set the Subnet ID for the session host
# You can get the Subnet ID from the terraform output in the first directory
$subnets = terraform -chdir="..\1-create-domain-controller" output -json subnets | ConvertFrom-Json

# There are hardcoded values in the `avd-ephemeral-host-parameters.json` file. You will need to update
# these values to match your environment. In particular, the following values should be changed:
# - administratorAccountUsername
# - domain
# - ouPath
# - location

# The rest of the parameter values should be left as-is.

# Deploy the template with the parameters file and some extra information
New-AzResourceGroupDeployment -Name "SessionHost" `
 -ResourceGroupName $resourceGroupName `
 -Mode Incremental `
 -TemplateParameterFile ".\avd-ephemeral-host-parameters.json" `
 -TemplateFile ".\avd-ephemeral-host.json" `
 -administratorAccountPassword $domainAdmin.Password `
 -vmAdministratorAccountPassword $vmAdmin.Password `
 -hostpoolName $hostPool `
 -hostpoolToken $hostPoolToken `
 -subnet-id $subnets.poolSubnet