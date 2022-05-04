# Create network interface for the session hosts on the subnet
resource "azurerm_network_interface" "session_host" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "session_host" {
  count                 = var.vm_count
  name                  = "${var.vm_name}-${count.index}"
  location              = var.location
  resource_group_name   = var.resource_group
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.session_host[count.index].id]
  license_type          = "Windows_Client"
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

}

resource "azurerm_virtual_machine_extension" "domainjoin" {
  count                      = var.vm_count
  name                       = "join-domain"
  virtual_machine_id         = azurerm_windows_virtual_machine.session_host[count.index].id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
  settings                   = <<SETTINGS
    {
        "name": "${var.domain}",
        "ouPath": "${var.oupath}",
        "user": "${var.domainuser}",
        "restart": "true",
        "options": "3"
    }
SETTINGS

  protected_settings = <<P_SETTINGS
    {
        "password": "${var.domainpassword}"
    }
P_SETTINGS

}

resource "azurerm_virtual_machine_extension" "avd_agent" {
  count              = var.vm_count
  name               = "avd-agent"
  virtual_machine_id = azurerm_windows_virtual_machine.session_host[count.index].id
  depends_on = [
    azurerm_virtual_machine_extension.domainjoin
  ]
  publisher                  = "Microsoft.PowerShell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "modulesUrl": "${var.artifactslocation}",
        "configurationFunction": "Configuration.ps1\\AddSessionHost",
        "properties": {
            "hostPoolName": "${var.hostpoolname}",
            "registrationInfoToken": "${var.regtoken}"
        }
    }
SETTINGS
}