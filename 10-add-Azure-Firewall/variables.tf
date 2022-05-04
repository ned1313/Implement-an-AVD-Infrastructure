# We'll need the following variables:
# Subnet id for Azure Firewall
# VNET id for spoken vnet
# VNET id for hub vnet?

variable "location" {
  type        = string
  description = "(Optional) The Azure region where the resources should be created."
  default     = "westus"
}

variable "prefix" {
  type        = string
  description = "(Optional) The prefix for the name of the resources."
  default     = "avd"
}

variable "fw_subnet_id" {
  type        = string
  description = "(Required) Azure Subnet ID for Azure Firewall."
}

variable "hub_vnet_resource_group" {
  type        = string
  description = "(Required) The name of the resource group for the Hub VNet."
}
