variable "location" {}
variable "resource_group_name" {}

variable "hub_address_space" {
  type = list(string)
}
variable "hub_subnet_prefixes" {
  type = list(string)
}

variable "gateway_subnet_prefixes" {
  type = list(string)
}
variable "firewall_subnet_prefixes" {
  type = list(string)
}


# Variable for spoke
variable "spokes" {
  type = map(object({
    address_space   = list(string)
    subnet_prefixes = list(string)
  }))
}
