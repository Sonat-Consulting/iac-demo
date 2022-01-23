param location string
param insightsConnectionString string
param insightsInstrumentationKey string

param namePrefix string
param skuName string
param skuTier string

@secure()
param mySecret string

resource demoappplan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'demo-app-plan'
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    tier: skuTier
    name: skuName
  }
}

resource demoapp 'Microsoft.Web/sites@2021-02-01' = {
  name: '${namePrefix}-${resourceGroup().name}-app'
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
        {
          name: 'Secrets__MySecret'
          value: mySecret
        }
      ]
      linuxFxVersion: 'DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest'
    }
    serverFarmId: demoappplan.id
  }
}
