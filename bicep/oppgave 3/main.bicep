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

    mySecret: kv.getSecret('my-secret-value')
  }
}

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: 'iac-common-kv'
  scope: resourceGroup('iac-common')
}
