locals {
  base_name = "${var.prefix}-bastion-${data.azurerm_resource_group.hub_vnet.location}"
}

data "azurerm_resource_group" "hub_vnet" {
  name = var.hub_vnet_resource_group
}

# Create a public IP address for the bastion host
resource "azurerm_public_ip" "hub_bastion" {
  name                = local.base_name
  resource_group_name = data.azurerm_resource_group.hub_vnet.name
  location            = data.azurerm_resource_group.hub_vnet.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create the bastion host subnet
resource "azurerm_subnet" "hub_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = data.azurerm_resource_group.hub_vnet.name
  virtual_network_name = var.hub_vnet_name
  address_prefixes     = [var.bastion_subnet_ip_range]
}
# Create the bastion host
resource "azurerm_bastion_host" "hub_bastion" {
  name                = local.base_name
  resource_group_name = data.azurerm_resource_group.hub_vnet.name
  location            = data.azurerm_resource_group.hub_vnet.location

  ip_configuration {
    name                 = "ipconfig1"
    subnet_id            = azurerm_subnet.hub_bastion.id
    public_ip_address_id = azurerm_public_ip.hub_bastion.id
  }
}