# We are going to create storage for an AVD host pool
locals {
  base_name    = "${var.prefix}-W10-MS-storage"
  storage_name = "${lower(var.prefix)}${random_string.storage_name.result}"
}

# Create a random storage account name
resource "random_string" "storage_name" {
  length  = 6
  special = false
  upper   = false
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "base" {
  name     = local.base_name
  location = var.location
}

resource "azurerm_storage_account" "fslogix" {
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.base.name
  location                 = azurerm_resource_group.base.location
  account_tier             = "Premium"
  account_kind             = "FileStorage"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "fslogix" {
  name                 = "profiles"
  storage_account_name = azurerm_storage_account.fslogix.name
  quota                = 100
}