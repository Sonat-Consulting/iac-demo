# Infrastructure as Code med Microsoft Bicep

Dokumentasjon for Bicep finnes her:    
https://docs.microsoft.com/en-us/azure/templates/


## Oppgave 1
Lag et Bicep script med navnet `webapp.bicep` som oppretter følgende:
1. En App Service Plan
    * kind: Linux
    * sku tier: Basic
    * sku name: B1
2. En app service som bruker denne app-plan:
    * appSettings: DOCKER_REGISTRY_SERVER_URL = https://ghcr.io og 
    * linuxFxVersion = DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest

Lag en ressursgruppe via Azure portalen. og deploy scriptet til ressursgruppen med følgende kommando. Bruk "-w" for å få en preview av hvilke endringer som blir gjort:

```
$ az deployment sub group create --resource-group {navn-på-ressursgruppe} --name {navn-på-deploy} --template-file webapp.bicep
```

## Oppgave 2
1. Lag en Log Analytics Workspace og en Application Insights.
   * tip: Log Analytics Workspace heter "Microsoft.OperationalInsights/workspaces" i Bicep.
   * tip: Application Insights heter "Microsoft.Insights/components" i Bicep.
   * tip: Bruk sku name `PerGB2018` i Log Analytics Workspace
2. Kople App Servicen til den opprettede Application Insights.
3. Gjør location om til en parameter. Lag også en navne-prefix som parameter.
4. Lag en parameterfil: `main.parameters-dev.json` som setter parametre.    
   Se dokumentasjon for parameterfiler her: https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files
5. Flytt Application Insights og Log Analytics Workspace til en egen fil (modul), og lag et `main.bicep` script som kaller modulene.
   Tips: Bruk output fra insights-modulen for å sette insightsConnectionString og insightsInstrumentationKey i webapp-modulen.

Deploy med følgende kommando:
```
$ az deployment sub create --name {navn-på-deploy} --location NorwayEast --template-file main.bicep --parameters main.parameters-dev.json
```

**Ekstraoppgave**: Flytt sku-settings ut i parameter-filen. Prøv å eksperimenter med å opprette ulike miljøer med ulik location og sku.

## Oppgave 3
1. Hent inn verdi fra keyvault, og gjør den tilgjengelig i appen
   * sett appSettings `Secrets__MySecret` til verdien fra key vault.
   * Key vault heter `iac-common-kv` og ligger i `iac-common` ressursgruppen.
   * sjekk `/secret` for å se om appen har fått hemmeligheten som parameter inn. 