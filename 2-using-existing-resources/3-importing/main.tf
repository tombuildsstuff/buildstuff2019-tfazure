provider "azurerm" {
  version = "=1.36.1"
}

# /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/tom-buildstuff-manual
resource "azurerm_resource_group" "example" {
  name     = "tom-buildstuff-manual"
  location = "West Europe"
}
