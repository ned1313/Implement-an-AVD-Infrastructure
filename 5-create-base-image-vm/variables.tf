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

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the subnet to create the VM in."
}

variable "vmadmin_username" {
  type        = string
  description = "(Required) The username for the VM."
}

variable "vmadmin_password" {
  type        = string
  description = "(Required) The password for the VM."
  sensitive   = true
}