variable "display_name" {
  description = "The display name of the management group."
  type        = string
}

variable "parent_management_group_id" {
  description = "The ID of the parent management group."
  type        = string
  default     = null
}

variable "custom_depends_on" {
  description = "Explicit dependencies for the management group."
  type        = list(any)
  default     = []
}



