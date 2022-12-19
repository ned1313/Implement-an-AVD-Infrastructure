terraform {

  cloud {

    organization = "ned-in-the-cloud"
    workspaces {
      name = "avd-workspace"
    }
  }
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}