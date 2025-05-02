terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.2.0"
    }
  }
}

provider "azurerm" {
  #resource_provider_registrations = "none"
  subscription_id = "c105447e-3a84-4cf0-bad0-69a86e309f90"
  features {

  }
}