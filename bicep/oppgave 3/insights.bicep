param location string

resource appanalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  location: location
  name: 'demo-log-workspace'
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource appinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'demo-app-analytics'
  location: location
  kind: 'web'
  properties: {
     WorkspaceResourceId: appanalytics.id
     Application_Type: 'web'
     RetentionInDays: 30
  }
}

output applicationInsightsConnectionString string = appinsights.properties.ConnectionString 
output applicationInsightsInstrumentationKey string = appinsights.properties.InstrumentationKey
