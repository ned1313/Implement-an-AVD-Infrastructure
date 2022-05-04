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

variable "vnet_spoke_address_space" {
  type        = string
  description = "(Optional) The address space for the virtual network."
  default     = "10.42.0.0/16"
}

variable "dc_private_ip_address" {
  type        = string
  description = "(Required) The private IP address of the DC in the hub network."
}

variable "poolSubnet_address_space" {
  type        = string
  description = "(Optional) The address space for the pool subnet."
  default     = "10.42.0.0/24"
}

variable "hub_vnet_name" {
  type        = string
  description = "(Required) The name of the hub virtual network."
}

variable "hub_vnet_id" {
  type        = string
  description = "(Required) The ID of the hub virtual network."

}

variable "hub_vnet_resource_group" {
  type        = string
  description = "(Required) The name of the resource group for the hub virtual network."
}

# Variables for session hosts
variable "session_host_admin_username" {
  type        = string
  description = "(Required) The admin username for the session host."
}

variable "session_host_admin_password" {
  type        = string
  sensitive   = true
  description = "(Required) The admin password for the session host."

}

variable "session_host_domain" {
  type        = string
  description = "(Required) The AD domain for the session host."
}

variable "session_host_domainuser" {
  type        = string
  description = "(Required) The AD domain user for the session host."

}

variable "session_host_domainpassword" {
  type        = string
  sensitive   = true
  description = "(Required) The AD domain password for the session host."

}

variable "session_host_oupath" {
  type        = string
  description = "(Required) The OU path for the session host."
}