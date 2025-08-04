resource "aws_instance" "Example" {
  ami           = "UR AMI id "
  instance_type = "t2.micro"
  security_groups = ["your-security-group"]
  tags = {
    name = "TerraformServer"
  }
}

resource "azurerm_virtual_machine" "Example" {
  name                  = "AzureVM"
  location              = "eastus"
  resource_group_name   = "your-resource-group"
  network_interface_ids = ["your-nic-id"]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}