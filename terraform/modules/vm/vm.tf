resource "azurerm_network_interface" "nic" {
  name                = "myNIC"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "myVM"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBgja7qxZeuBCjaq277COloW/hOkVxJoCwl23VNGE7113OPqk19qCNqI0PKYeWmF3LYk346RtfdMpWI3mPsrV2UI4f72JCDxkgRsSajcMFkop68KV2jhtGnLfH9wUgnd1lOu+KAokvhV2VIQljy7Zd2NvSdDq0eCG5ggwoqVbVicxsXa5W+ITeL5a1VZNLAqPLpraiE74c/OhYRwJ7HmixDY+nzOUIsi82ieDD0LTF232IjN+EAiXMWXpOayf5E71cXqQlkgSPbdTE1oLHceSN4hjnP6De4z45MQuE+XDJ20XZgcw5Aw22TioEXmSi83TnERWmIUFMC/U0eIS0uHTF3NzHx9qnB5Wufm9SC+h4yM/V2fM3CXIENEL0LrBsi/zrNtTURdt37pdMXhSfE1p0ZYQZu5okUkDB0fmsTqn+DLC0xxMCHcAISPGsb+VOPQs+z1lhrNfj3Spm11uhlnPnBor1XfL0rD+M0kIz356kfguZtdI2RRrKscFEr8lOiys= odl_user@SandboxHost-638258461049149286"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
