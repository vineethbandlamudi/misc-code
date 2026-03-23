resource "azurerm_public_ip" "publicip" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "privateip" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name


  ip_configuration {
    name                          = var.name
    subnet_id                     = "/subscriptions/721ea30a-1562-42c5-89d7-30aeb9ce9522/resourceGroups/project-setup/providers/Microsoft.Network/virtualNetworks/roboshop-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id

  }
}

resource "azurerm_network_interface_security_group_association" "nsg_attach" {
  network_interface_id      = azurerm_network_interface.privateip.id
  network_security_group_id = "/subscriptions/721ea30a-1562-42c5-89d7-30aeb9ce9522/resourceGroups/project-setup/providers/Microsoft.Network/networkSecurityGroups/allow-all"
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.name
  location              = var.rg_location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.privateip.id]
  disable_password_authentication = false
  size               = var.vm_size
  admin_username = "azuser"
  admin_password = "DevOps@123456"

  source_image_id       = "/subscriptions/721ea30a-1562-42c5-89d7-30aeb9ce9522/resourceGroups/project-setup/providers/Microsoft.Compute/images/test-vm-project-image-20260306200821"

  os_disk {
    name                  = "${var.name}-disk"
    caching               = "ReadWrite"
    storage_account_type  = "Standard_LRS"
  }

  priority = "spot"
  eviction_policy = "Deallocate"
  max_bid_price = -1

}

resource "azurerm_dns_a_record" "public_dns_record" {
  depends_on = [azurerm_linux_virtual_machine.vm]
  name                = var.name
  resource_group_name = var.rg_name
  zone_name           = "vdevops.io"
  ttl                 = 3
  records             = [azurerm_public_ip.publicip.ip_address]
}

resource "azurerm_dns_a_record" "private_dns_record" {
  name                = "${var.name}-int"
  resource_group_name = var.rg_name
  zone_name           = "vdevops.io"
  ttl                 = 3
  records             = [azurerm_network_interface.privateip.private_ip_address]
}