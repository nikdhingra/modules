resource "azurerm_virtual_network" "spoke" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "spoke_subnet" {
  name                 = "spoke-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.subnet_prefixes
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "${var.name}-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hub_vnet_id
  allow_forwarded_traffic   = true
  use_remote_gateways       = true
  
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "hub-to-${var.name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = split("/", var.hub_vnet_id)[8] # get VNet name from ID
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  
}

output "vnet_id" {
  value = azurerm_virtual_network.spoke.id
}
