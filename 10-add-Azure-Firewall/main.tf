# Azure Firewall Config
locals {
  base_name = "${var.prefix}-FW-${data.azurerm_resource_group.hub_vnet.location}"
}

data "azurerm_resource_group" "hub_vnet" {
  name = var.hub_vnet_resource_group
}

## Public IP addresses for firewall
resource "azurerm_public_ip" "hub_firewall" {
  name                = local.base_name
  resource_group_name = data.azurerm_resource_group.hub_vnet.name
  location            = data.azurerm_resource_group.hub_vnet.location
  allocation_method   = "Static"
  sku                 = "Standard"
}


## Azure firewall creation
resource "azurerm_firewall" "hub_firewall" {
  name                = local.base_name
  resource_group_name = data.azurerm_resource_group.hub_vnet.name
  location            = data.azurerm_resource_group.hub_vnet.location

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration {
    name                 = "ipconfig1"
    subnet_id            = var.fw_subnet_id
    public_ip_address_id = azurerm_public_ip.hub_firewall.id
  }

  firewall_policy_id = azurerm_firewall_policy.hub_fw_base_policy.id

  depends_on = [
    azurerm_firewall_policy_rule_collection_group.hub_fw_base_policy
  ]

}

# Firewall policies
resource "azurerm_firewall_policy" "hub_fw_base_policy" {
  name                     = local.base_name
  resource_group_name      = data.azurerm_resource_group.hub_vnet.name
  location                 = data.azurerm_resource_group.hub_vnet.location
  sku                      = "Standard"
  threat_intelligence_mode = "Deny"

  dns {
    proxy_enabled = true
  }

}


## Network rules
resource "azurerm_firewall_policy_rule_collection_group" "hub_fw_base_policy" {
  name               = local.base_name
  firewall_policy_id = azurerm_firewall_policy.hub_fw_base_policy.id
  priority           = 200

  network_rule_collection {
    name     = "avd-network-rules"
    priority = 200
    action   = "Allow"

    rule {
      name                  = "DNS"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }

    rule {
      name                  = "HTTP"
      protocols             = ["TCP"]
      source_addresses      = ["*"]
      destination_addresses = ["169.254.169.254", "168.63.129.16"]
      destination_ports     = ["80"]
    }

    rule {
      name                  = "HTTPS"
      protocols             = ["TCP"]
      source_addresses      = ["*"]
      destination_addresses = ["AzureCloud", "WindowsVirtualDesktop"]
      destination_ports     = ["443"]
    }

    rule {
      name                  = "KMS"
      protocols             = ["TCP"]
      source_addresses      = ["*"]
      destination_addresses = ["23.102.135.246"]
      destination_ports     = ["1688"]
    }

    rule {
      name              = "NTP"
      protocols         = ["UDP"]
      source_addresses  = ["*"]
      destination_fqdns = ["time.windows.com"]
      destination_ports = ["123"]
    }
  }

  application_rule_collection {
    name     = "avd-application-rules"
    priority = 300
    action   = "Allow"

    rule {
      name             = "AVD-Services"
      source_addresses = ["*"]
      destination_fqdn_tags = [
        "WindowsVirtualDesktop",
        "WindowsUpdate",
        "WindowsDiagnostics",
        "MicrosoftActiveProtectionService"
      ]
      protocols {
        type = "Https"
        port = 443
      }
    }
  }
}

# User Defined Route to Azure Firewall
resource "azurerm_route_table" "azure_firewall" {
  name                = local.base_name
  resource_group_name = data.azurerm_resource_group.hub_vnet.name
  location            = data.azurerm_resource_group.hub_vnet.location

  route {
    name                   = "AzureFirewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.hub_firewall.ip_configuration[0].private_ip_address
  }
}