# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/8"]
}

# snet3 Subnet Name
variable "snet3_subnet_name" {
  description = "Virtual Network snet3 Subnet Name"
  type = string
  default = "snet3"
}
# snet3 Subnet Address Space
variable "snet3_subnet_address" {
  description = "Virtual Network snet3 Subnet Address Spaces"
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "ssh_public_key" {
  default = "~/.ssh/aks-prod-sshkeys-terraform/aksprodsshkey.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}