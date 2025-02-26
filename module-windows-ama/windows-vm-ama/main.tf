# main.tf

# Resource Group
resource "azurerm_resource_group" "example" {
  name =  var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "example"{
  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = var.vnet_address_space
}

# Subnet
resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefix
  depends_on = [ azurerm_virtual_network.example ]
}

# Network Interface
resource "azurerm_network_interface" "example" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  ip_configuration {
    name                          = "internal"
    subnet_id                    = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
  
}

# Virtual Machine with AMA
resource "azurerm_virtual_machine" "example" {
  name                         = var.vm_name
  location                     = var.location
  resource_group_name          = azurerm_resource_group.example.name
  network_interface_ids        = [azurerm_network_interface.example.id]
  vm_size                      = var.vm_size
  
  

   storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  
  storage_os_disk {
    name              = var.os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type =  "Standard_LRS"
  }

   os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
    enable_automatic_upgrades = false
  }


  tags = var.vm_tags
}

# Optional: Install Azure Monitoring Agent (AMA) on the VM
resource "azurerm_virtual_machine_extension" "ama_extension" {
  name                 = "enable-ama"
  virtual_machine_id   = azurerm_virtual_machine.example.id
  publisher             = "Microsoft.Azure.Extensions"
  type                  = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
{
  "script": "./scripts/install-ama.ps1"  
}
SETTINGS
}
