variable "tools" {
  default = {
    vault = {
      vm_size = "Standard_D2s_v3"
    }
  }
}

variable "rg_name" {
  default = "project-setup"
}

variable "rg_location" {
  default = "UK West"
}