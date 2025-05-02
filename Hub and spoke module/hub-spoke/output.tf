# HUB VNET ID

output "hub_vnet_id" {
  value = module.hub.vnet_id
}

# Spoke VNET ID
output "spoke_vnet_ids" {
  value = {
    for k, mod in module.spokes : k => mod.vnet_id
  }
}
