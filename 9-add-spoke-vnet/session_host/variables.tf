# Shout out to buildVirtual for this
# https://buildvirtual.net/how-to-deploy-wvd-session-hosts-using-terraform/
variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Azure resources"
}

variable "location" {
  type        = string
  description = "(Required) The location/region where the session hosts are created"
}

variable "vm_size" {
  type        = string
  description = "(Optional) Specifies the size of the virtual machine. Defaults to Standard_D2s_v3"
  default     = "Standard_D2s_v3"
}

variable "image_publisher" {
  type        = string
  description = "(Optional) Image Publisher for session host. Defaults to MicrosoftWindowsDesktop."
  default     = "MicrosoftWindowsDesktop"
}

variable "image_offer" {
  type        = string
  description = "(Optional) Image Offer for session host. Defaults to Windows-10."
  default     = "Windows-10"
}

variable "image_sku" {
  type        = string
  description = "(Optional) Image SKU for session host. Defaults to win10-21h2-avd"
  default     = "win10-21h2-avd"
}

variable "image_version" {
  type        = string
  description = "(Optional) Image Version for session host. Defaults to latest."
  default     = "latest"
}

variable "admin_username" {
  type        = string
  description = "(Optional) Local Admin Username for session host. Defaults to avdAdmin."
  default     = "avdAdmin"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "(Required) Local Admin Password for session host."
}

variable "subnet_id" {
  type        = string
  description = "(Required) Azure Subnet ID for session host."
}

variable "vm_name" {
  type        = string
  description = "(Required) Virtual Machine Name prefix for session host."
}

variable "vm_count" {
  type        = number
  description = "(Required) Number of Session Host VMs to create"
  default     = 1
}

variable "domain" {
  type        = string
  description = "(Required) Domain to join"

}

variable "domainuser" {
  type        = string
  description = "(Required) Domain Join User Name"
}

variable "oupath" {
  type        = string
  description = "(Required) OU Path"
}

variable "domainpassword" {
  type        = string
  sensitive   = true
  description = "(Required) Domain User Password"
}

variable "regtoken" {
  type        = string
  sensitive   = true
  description = "(Required) Host Pool Registration Token"
}

variable "hostpoolname" {
  description = "(Required) Host Pool Name to Register Session Hosts"
}

variable "artifactslocation" {
  type        = string
  description = "(Optional) Location of WVD Artifacts"
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration.zip"
}