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

module "windows_vm" {
  source                = "./windows-vm" # Path to the directory containing the module
  resource_group_name   = "myResourceGroup"
  location              = "West Europe"
  vnet_name             = "myVnet"
  vnet_address_space    = ["10.0.0.0/16"]
  subnet_name           = "mySubnet"
  subnet_address_prefix = ["10.0.1.0/24"]
  nic_name              = "myNIC"
  vm_name               = "myWindowsVM"
  admin_username        = "adminuser"
  admin_password        = "SecurePassword123"
  os_disk_name          = "myOSDisk"
  vm_tags = {
    environment = "production"
  }

}

output "vm_id" {
  value = module.windows_vm.vm_id
}
