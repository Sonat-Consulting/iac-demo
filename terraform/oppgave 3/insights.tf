resource "azurerm_log_analytics_workspace" "analytics_workspace" {
  name                = "swapi-analytics-workspace"
  location            = data.azurerm_resource_group.swapi_rg.location
  resource_group_name = data.azurerm_resource_group.swapi_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "swapi_insights" {
  name                = "swapi-dotnet-insights"
  location            = data.azurerm_resource_group.swapi_rg.location
  resource_group_name = data.azurerm_resource_group.swapi_rg.name
  workspace_id = azurerm_log_analytics_workspace.analytics_workspace.id
  application_type    = "web"
  retention_in_days   = 30
  
}