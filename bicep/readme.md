# Infrastructure as Code med Microsoft Bicep

## Oppgave 1
Lag et Bicep script med navnet `webapp.bicep` som oppretter følgende:
1. En App Service Plan
    * kind: Linux
    * sku tier: Basic
    * sku name: B1
2. En app service som bruker denne app-plan:
    * appSettings: DOCKER_REGISTRY_SERVER_URL = https://ghcr.io og 
    * linuxFxVersion = DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest

Lag en ressursgruppe via Azure portalen, og deploy scriptet til ressursgruppen med følgende kommando:

```
$ az deployment group create --resource-group {navn_på_ressursgruppe} --name cubit-demo-iac-deploy --template-file webapp.bicep
```

## Oppgave 2
1. Modifiser `webapp.bicep` med følgende endringer:
   * Gjør `location` om til en parameter.
   * Opprett parameter `insightsConnectionString`. Denne skal sette appSetting: `APPLICATIONINSIGHTS_CONNECTION_STRING`.
   * Opprett parameter `insightsInstrumentationKey`. Denne skal sette appSetting: `APPINSIGHTS_INSTRUMENTATIONKEY`.
2. Lag ett nytt script som heter `insights.bicep`. Dette scriptet skal opprette følgende:
   * Log Analytics Workspace'
       * Sku name: `PerGB2018`
   * Application Insights, som bruker den genererte Log Analytics Workspace som backend
       * kind: web
       * properties Application_Type: web
       * properties RetentionInDays: 30
       * gjør location til en parameter
3. Lag en parameterfil: `main.parameters-dev.json`, som setter en navn-prefix og location.    
   Se dokumentasjon for parameterfiler her: https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files
4. Lag et `main.bicep` script, som kaller `webapp.bicep` og `insights.bicep`, og parameter-verdier.       
   Tips: Bruk output fra insights-modulen for å sette insightsConnectionString og insightsInstrumentationKey i webapp-modulen.

Deploy med følgende kommando:
```
$ az deployment group create --resource-group {navn_på_ressursgruppe} --name cubit-demo-iac-deploy --template-file main.bicep --parameters main.parameters-dev.json
```

**Ekstraoppgave**: Flytt sku-settings ut i parameter-filen. Prøv å eksperimenter med å opprette ulike miljøer med ulik location og sku.

## Oppgave 3
1. Hent inn verdi fra keyvault, og gjør den tilgjengelig i appen
   * sett appSettings `Secrets__MySecret` til verdien fra key vault.
   * Key vault heter `iac-common-kv` og ligger i `iac-common` ressursgruppen.
   * sjekk `/secret` for å se om appen har fått hemmeligheten som parameter inn. 