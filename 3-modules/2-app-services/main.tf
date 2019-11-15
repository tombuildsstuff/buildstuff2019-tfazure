module "working-environments" {
  source = "./modules/app-service"
  prefix = var.prefix
  location = "West Europe"

  environments = {
    staging = "Hello from Staging"
    ci      = "Hello from CI"
  }
}

output "active_website" {
  value = module.working-environments.active_website
}

output "websites" {
  value = module.working-environments.websites
}
