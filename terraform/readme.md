# Infrastructure as Code with Terraform

## Oppgave 1
Lag en ny resursgruppe via Azure portalen.
Lag et terraform-script som setter følgende opp i ressursgruppen:
1. En App Service plan
   * kind = "Linux"
   * sku tier "Basic"
   * sku size "B1"
2. En App Service som bruker denne app-plan:
   * appSettings: "DOCKER_REGISTRY_SERVER_URL" = "https://ghcr.io"
   * linux_fx_version = "DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest"

## Oppgave 2
1. Lag et script som setter opp en Application Insights og en Log Analytics Workspace    
   Med samme oppsett for tilsvarende Bicep oppgave
2. Lag en variables.tf fil som beskriver følgende variabler:
   * App plan tier
   * App plan size
   * navn-prefix
3. Lag en tfvars-fil kalt "dev.tfvars", og legg inn ønskede verdier.

kjør scriptet med
```
$ terraform init
$ terraform plan --var-file .\dev.tfvars
$ terraform apply --var-file .\dev.tfvars
```

## Oppgave 3
Hent inn secret fra key vault.
* Key vault heter `iac-common-kv` og ligger i `iac-common` ressursgruppen.
* Secret har key = `my-secret-value`
* Denne skal settes til appSettings verdien `Secrets__MySecret`
