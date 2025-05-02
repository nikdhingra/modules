variable "name" {}
variable "address_space" {
  type = list(string)
}
variable "subnet_prefixes" {
  type = list(string)
}
variable "location" {}
variable "resource_group_name" {}
variable "hub_vnet_id" {}

variable "vpn_gateway_id" {
  type        = string
  description = "ID of the hub VPN gateway for dependency"
}
