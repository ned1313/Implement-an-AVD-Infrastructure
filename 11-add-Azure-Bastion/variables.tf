variable "prefix" {
  type        = string
  description = "(Optional) The prefix for the name of the resources."
  default     = "avd"
}

variable "hub_vnet_resource_group" {
  type        = string
  description = "(Required) The name of the resource group for the Hub VNet."
}

variable "hub_vnet_name" {
  type        = string
  description = "(Required) The name of the resource group for the Hub VNet."
}

variable "bastion_subnet_ip_range" {
  type        = string
  description = "(Required) The IP range for the Bastion Subnet."
}