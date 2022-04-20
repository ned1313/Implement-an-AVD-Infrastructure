# Set the resource group and hostpool names
resource_group_name="RESOURCE_GROUP_NAME"
hostpool_name="HOSTPOOL_NAME"

az desktopvirtualization hostpool list --resource-group $resource_group_name
az desktopvirtualization hostpool list --resource-group $resource_group_name --query [].name

az desktopvirtualization hostpool show --name $hostpool_name --resource-group $resource_group_name