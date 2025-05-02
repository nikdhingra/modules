
# This block creates a hub virtual network.
resource "azurerm_virtual_network" "hub" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

# This block creates a subnets within the hub virtual network.
# Standard Subnet for the hub.
resource "azurerm_subnet" "hub_subnet" {
  name                 = "hub-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.subnet_prefixes
}

# Gateway Subnet for the hub. 
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.gateway_subnet_prefixes
}

# Firewall Subnet for the hub.
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.firewall_subnet_prefixes
}

# Public IP for the VPN Gateway.
resource "azurerm_public_ip" "vpn_gw" {
  name                = "${var.name}-gw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

# Virtual Network Gateway for the hub.
resource "azurerm_virtual_network_gateway" "vpn" {
  name                = "${var.name}-vpngw"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = true
  sku                 = "VpnGw1"
  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id         = azurerm_public_ip.vpn_gw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                    = azurerm_subnet.gateway_subnet.id
  }
  bgp_settings {
    asn = 65010  # <-- custom ASN
  }
}

# Public IP for the Azure Firewall.
resource "azurerm_public_ip" "firewall" {
  name                = "${var.name}-fw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall for the hub.
resource "azurerm_firewall" "fw" {
  name                = "${var.name}-firewall"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.hub.id
}
