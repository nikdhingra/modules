module "hub" {
  source              = "./modules/hub"
  name                = "hub-vnet"
  address_space       = var.hub_address_space
  subnet_prefixes     = var.hub_subnet_prefixes
  location            = var.location
  resource_group_name = var.resource_group_name
  gateway_subnet_prefixes  = var.gateway_subnet_prefixes
  firewall_subnet_prefixes = var.firewall_subnet_prefixes
}



module "spokes" {
  for_each = var.spokes

  source              = "./modules/spoke"
  vpn_gateway_id      = module.hub.vpn_gateway_id
  name                = each.key
  address_space       = each.value.address_space
  subnet_prefixes     = each.value.subnet_prefixes
  location            = var.location
  resource_group_name = var.resource_group_name
  hub_vnet_id         = module.hub.vnet_id
  depends_on = [module.hub]
}

data "azurerm_resource_group" "rg" {
  name     = "rg-hubspoke"
  
}