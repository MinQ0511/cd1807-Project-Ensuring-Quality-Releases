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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/+1Ysgul13y1LdMBG6oZPfw1muvJBQvLKw+2gdlW4VRvsuscxm34yn/q6qxSgZI/LFmq3Q9mxe9y7WqunNqV+uOOqE4XEd0UYWtx0DsOcrqFc6Resie5Xqkc5WWS2XD/LjMJEvBd4LD4WXceNlgCixbGBxjzx3Wf3Y/Ph7B2wqvsUJ1ER3JSbAYXnHTWdP+TYz8WrYArB24RawfcJVFZY99GijAjxZlnTNyI0iYvg1nYL7P3Z/iLir9ovYYpHZ3P6goiqRlVibrSuAH0Jx/rUR5l6TyQHAI3/oo2IQyTQpyI0thFBKkfjV8Ts5IT7kCGCbU5vrDHuo0lzP0eF71j4RA0HLgBcWbjZNA0zGST9qDJ08sS05qiPV0lT4AQJORnBA93Jrev8zDyMNVVjUa7Rt7RNDoaPr0ydOwrVFUzPSzvJ8C5SvMG4Wj+UJFwqW3GIK1+wxdtzzttsi9VTEnP6uAFrJxBgNPmLdgNo9cnEnNOyRccjNar7RpduN/ZkarM= odl_user@cc-c96f36d3-5f4566889b-qnxnm"
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
