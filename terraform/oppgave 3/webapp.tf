resource "azurerm_app_service_plan" "appserviceplan" {
  name = "swapi-app-plan"
  location = data.azurerm_resource_group.swapi_rg.location
  resource_group_name = data.azurerm_resource_group.swapi_rg.name
  kind = "Linux"
  reserved = true
  sku {
    tier = var.app_plan_tier
    size = var.app_plan_size
  }
}

resource "azurerm_app_service" "swapi_app_service" {
  name = "${var.env_prefix}-swapi-dotnet-app-terraform-app"
  location = data.azurerm_resource_group.swapi_rg.location
  resource_group_name = data.azurerm_resource_group.swapi_rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  site_config {
    linux_fx_version = "DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest"
  }

  app_settings = {
      "DOCKER_REGISTRY_SERVER_URL" = "https://ghcr.io"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.swapi_insights.connection_string
      "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.swapi_insights.instrumentation_key

      "Secrets__MySecret" = data.azurerm_key_vault_secret.my_app_secret.value
  }
}