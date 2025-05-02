variable "name" {}
variable "address_space" {
  type = list(string)
}
variable "subnet_prefixes" {
  type = list(string)
}
variable "location" {}
variable "resource_group_name" {}

variable "gateway_subnet_prefixes" {
  type = list(string)
}
variable "firewall_subnet_prefixes" {
  type = list(string)
}