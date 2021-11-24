param location string = resourceGroup().location

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
  }
}
