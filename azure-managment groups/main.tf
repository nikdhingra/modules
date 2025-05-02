module "pkakes" {
  source       = "./modules/management_group"
  display_name = "Pkakes"
}


# Platform management group and Associate subscription to the platform management group
module "platform" {
  source                     = "./modules/management_group"
  display_name               = var.platform_display_name
  parent_management_group_id = module.pkakes.id
  depends_on                 = [module.pkakes]
}

resource "azurerm_management_group_subscription_association" "platform_assoc" {
  subscription_id     = var.platform_subscription_id
  management_group_id = module.platform.id
}


# landing_zone management group and Associate subscription to the landing_zone management group

module "landing_zone" {
  source                     = "./modules/management_group"
  display_name               = "Landing zone"
  parent_management_group_id = module.pkakes.id
  depends_on                 = [module.pkakes]
}

# resource "azurerm_management_group_subscription_association" "landing_zone_assoc" {
#   subscription_id     = var.platform_subscription_id
#   management_group_id = module.landing_zone.id
# }


module "decommission" {
  source                     = "./modules/management_group"
  display_name               = "Decommission"
  parent_management_group_id = module.pkakes.id
  depends_on                 = [module.pkakes]
}

module "sandbox" {
  source                     = "./modules/management_group"
  display_name               = "Sandbox"
  parent_management_group_id = module.pkakes.id
  depends_on                 = [module.pkakes]
}

module "management" {
  source                     = "./modules/management_group"
  display_name               = "Management"
  parent_management_group_id = module.platform.id
  depends_on                 = [module.platform]
}

module "identity" {
  source                     = "./modules/management_group"
  display_name               = "Identity"
  parent_management_group_id = module.platform.id
  depends_on                 = [module.platform]
}

module "connectivity" {
  source                     = "./modules/management_group"
  display_name               = "Connectivity"
  parent_management_group_id = module.platform.id
  depends_on                 = [module.platform]
}

module "corp" {
  source                     = "./modules/management_group"
  display_name               = "Corp"
  parent_management_group_id = module.landing_zone.id
  depends_on                 = [module.landing_zone]
}

module "online" {
  source                     = "./modules/management_group"
  display_name               = "Online"
  parent_management_group_id = module.landing_zone.id
  depends_on                 = [module.landing_zone]
}



