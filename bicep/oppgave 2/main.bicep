param location string = resourceGroup().location

param namePrefix string
param planSkuName string
param planSkuTier string

module appInsightsModule './insights.bicep' = {
  name: 'appInsightsDeploy'
  params: {
    location: location
  }
}

module webAppModule './webapp.bicep' = {
  name: 'webAppModule'
  params: {
    location: location
    insightsConnectionString: appInsightsModule.outputs.applicationInsightsConnectionString
    insightsInstrumentationKey: appInsightsModule.outputs.applicationInsightsInstrumentationKey

    namePrefix: namePrefix
    skuName: planSkuName
    skuTier: planSkuTier
  }
}
