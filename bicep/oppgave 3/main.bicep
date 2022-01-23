targetScope = 'subscription'

param namePrefix string
param planSkuName string
param planSkuTier string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'larsaaberg-iacdemo'
  location: deployment().location
}

module appInsightsModule './insights.bicep' = {
  scope: rg
  name: 'appInsightsDeploy'
  params: {
    location: deployment().location
  }
}

module webAppModule './webapp.bicep' = {
  scope: rg
  name: 'webAppModule'
  params: {
    location: deployment().location
    insightsConnectionString: appInsightsModule.outputs.applicationInsightsConnectionString
    insightsInstrumentationKey: appInsightsModule.outputs.applicationInsightsInstrumentationKey

    namePrefix: namePrefix
    skuName: planSkuName
    skuTier: planSkuTier

    mySecret: kv.getSecret('my-secret-value')
  }
}

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: 'iac-demo-common-kv'
  scope: resourceGroup('iac-common')
}
