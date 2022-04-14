output "dc_admin_password" {
  value = nonsensitive(module.azure_dc.windows_vm_password)
}

output "dc_public_ip_address" {
  value = module.azure_dc.windows_vm_public_ips
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet_hub.id
}