# This will deploy a storage account for FSLogix to use
terraform init
terraform apply -auto-appove

# The remainder of the configuration is done in the Azure portal 
# and from the domain controller.