module "tools-vm" {
  source = "./vm"
  for_each = var.tools
  name     = each.key
  rg_name  = var.rg_name
  rg_location = var.rg_location
  vm_size = each.value["vm_size"]
}