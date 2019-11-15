provider "azurerm" {
  version = "=1.36.1"
}

resource "azurerm_resource_group" "test" {
  name = "buildstuff2019"
  location = "West Europe"

  tags = {
    Hello = "Build Stuff!"
  }
}
