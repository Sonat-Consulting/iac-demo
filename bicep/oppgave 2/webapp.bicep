param location string
param insightsConnectionString string
param insightsInstrumentationKey string

resource demoappplan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'demo-app-plan'
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    tier: 'Basic'
    name: 'B1'
  }
}

resource demoapp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'cubit-demo-app'
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://ghcr.io'
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: insightsConnectionString
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: insightsInstrumentationKey
        }
      ]
      linuxFxVersion: 'DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest'
    }
    serverFarmId: demoappplan.id
  }
}
