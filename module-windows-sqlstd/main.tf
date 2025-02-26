# main.tf in the root directory
# main.tf in the root directory
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
  subscription_id = "9bd2fe7b-8da1-4dad-ac7c-7766fe130a05"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }
}

module "windows-vm-sqlstd" {
  source                = "./windows-vm-sqlstd" # Path to the directory containing the module
  resource_group_name   = var.resource_group_name
  location              = var.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  subnet_name           = var.subnet_name
  subnet_address_prefix = var.subnet_address_prefix
  nic_name              = var.nic_name
  vm_name               = var.vm_name
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  os_disk_name          = var.os_disk_name
  vm_tags = {
    environment = "production"
    application = "sql2022"
  }

}


