provider "azurerm" {
  version = "=1.36.1"
}

# This assumes a Virtual Network named `tom-buildstuff-network` exists in the Resource Group `tom-buildstuff-network`.
data "azurerm_virtual_network" "development" {
  name                = "tom-buildstuff-network"
  resource_group_name = "tom-buildstuff-resources"
}

resource "azurerm_subnet" "my" {
  name                 = "my-subnet"
  resource_group_name  = data.azurerm_virtual_network.development.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.development.name
  address_prefix       = "172.0.1.0/24"
}
