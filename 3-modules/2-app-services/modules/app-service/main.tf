locals {
  download_url = "https://github.com/tombuildsstuff/legacy-mvc-net471/releases/download/v1.0.0/legacy-mvc-net-471.zip"
}

resource "azurerm_resource_group" "main" {
  name = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-asp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-appservice"
  location            = azurerm_app_service_plan.main.location
  resource_group_name = azurerm_app_service_plan.main.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "None"
  }

  app_settings = {
    Message              = "Hello from Production"
    WEBSITE_RUN_FROM_ZIP = local.download_url
  }

  lifecycle {
    ignore_changes = ["site_config"]
  }
}

resource "azurerm_app_service_slot" "main" {
  for_each = var.environments

  name                = each.key
  app_service_name    = azurerm_app_service.main.name
  location            = azurerm_app_service.main.location
  resource_group_name = azurerm_app_service.main.resource_group_name
  app_service_plan_id = azurerm_app_service.main.app_service_plan_id

  app_settings = {
    Message              = each.value
    WEBSITE_RUN_FROM_ZIP = local.download_url
  }
}

output "active_website" {
  value = "https://${azurerm_app_service.main.default_site_hostname}"
}

output "websites" {
  value = {
    for slot in azurerm_app_service_slot.main:
    slot.name => "https://${slot.default_site_hostname}"
  }
}
