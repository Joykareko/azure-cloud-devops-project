variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vm_count" {
  description = "Number of virtual machines"
  type        = number
  default = 2
}

variable "packer_image_id" {
  description = "ID of the Packer-built image"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
}

variable "tags" {
  description = "Mandatory tags"
  type        = map(string)
}
