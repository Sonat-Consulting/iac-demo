resource "azurerm_app_service_plan" "appserviceplan" {
  name = "swapi-app-plan"
  location = data.azurerm_resource_group.swapi_rg.location
  resource_group_name = data.azurerm_resource_group.swapi_rg.name
  kind = "Linux"
  reserved = true
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "swapi_app_service" {
  name = "swapi-dotnet-app-terraform-app"
  location = data.azurerm_resource_group.swapi_rg.location
  resource_group_name = data.azurerm_resource_group.swapi_rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  site_config {
    linux_fx_version = "DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest"
  }

  app_settings = {
      "DOCKER_REGISTRY_SERVER_URL" = "https://ghcr.io"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}