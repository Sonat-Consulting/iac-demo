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
    mySecret: kv.getSecret('my-secret-value')
  }
}

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: 'cubit-kv'
  scope: resourceGroup('cubit-global')
}
