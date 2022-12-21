# We are going to use the portal to provision the NetApp Files account and file share
# In case you wanted to use the CLI, here are the commands

# Log into Azure
az login
az account set -s "Your_Subscription_Name"

location="LOCATION"

# Create a resource group
az group create --name "avd-netapp" --location $location

# Register the netapp provider
az provider register --namespace Microsoft.NetApp --wait

# Create the NetApp Files account
az netappfiles account create --resource-group "avd-netapp" \
  --location $location --account-name "avdnetapp"

# Create an Active Directory connection
aduser="AD_USER" # username only, no domain component
adpass='AD_PASSWORD'
dcipaddress="DC_IP_ADDR" # IPv4 address of the domain controller
domainname="DOMAIN_NAME" # e.g. contoso.com
site="SITE_NAME" # e.g. Default-First-Site-Name
oupath="OU_PATH" # No DC component, e.g. OU=NetApp

az netappfiles account ad add -g "avd-netapp" \
  --name "avdnetapp" --username $aduser \
  --password $adpass --smb-server-name ANF \
  --dns $dcipaddress --domain $domainname \
  --site $site --organizational-unit $oupath

# Create the NetApp Files pool
# Premium is recommended for production
az netappfiles pool create --resource-group "avd-netapp" \
  --location $location --account-name "avdnetapp" \
  --pool-name "avdpool" --service-level "Standard" --size 4

# Create the NetApp Files volume
vnetID="VNET_ID" # Resource ID of the VNET
subnetName="SUBNET_NAME" # Name of the subnet
az netappfiles volume create -g "avd-netapp" \
  --account-name "avdnetapp" --pool-name "avdpool" \
  --name "avd-vol01" -l $location \
  --service-level "Standard" --usage-threshold 100 \
  --file-path "avd-vol01" --vnet $vnetID \
  --subnet $subnetName --protocol-types CIFS \
  --network-features "Standard"
