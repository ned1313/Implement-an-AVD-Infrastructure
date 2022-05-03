# We are going to create an AVD host pool
locals {
  base_name = "${var.prefix}-W10-D"
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "base" {
  name     = local.base_name
  location = var.location
}

resource "azurerm_virtual_desktop_host_pool" "personal" {
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name

  name                             = local.base_name
  validate_environment             = false
  description                      = "Personal Virtual Desktop Host Pool for Ephemeral Disk"
  type                             = "Personal"
  load_balancer_type               = "Persistent"
  personal_desktop_assignment_type = "Automatic"

}

resource "azurerm_virtual_desktop_workspace" "personal" {
  name                = "${local.base_name}-westus"
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name
}

resource "azurerm_virtual_desktop_application_group" "desktopapp" {
  name                = "${local.base_name}-DAG"
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name

  type         = "Desktop"
  host_pool_id = azurerm_virtual_desktop_host_pool.personal.id
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "desktopapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.personal.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopapp.id
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "personal" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.personal.id
  expiration_date = timeadd(timestamp(), "24h")
}