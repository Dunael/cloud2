variable "resource_group_location" {
  default     = "francecentral"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "AMI_ID" {
    default = "AMI_ID"
    description = "Identifiant de la VM nouvellement créée"
}
