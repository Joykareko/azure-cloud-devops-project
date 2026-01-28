packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 1.0.0"
    }
  }
}

source "azure-arm" "ubuntu" {
  use_azure_cli_auth = true
  subscription_id   = "bb90f4ea-a7ed-462c-abe0-20478893b26d"

  build_resource_group_name          = "Azuredevops"
  managed_image_resource_group_name  = "Azuredevops"
  managed_image_name                 = "udacity-server-image"


  vm_size  = "Standard_DS1_v2"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"

  azure_tags = {
    project     = "udacity-devops"
    owner       = "joy"
    environment = "dev"
  }
}

build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
