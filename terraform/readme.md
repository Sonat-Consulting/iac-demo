# Infrastructure as Code with Terraform
Dokumentasjon finnes på https://www.terraform.io/
Velg "Registry" -> "Azure" -> "Documentation"

## Oppgave 1
Lag en ny resursgruppe via Azure portalen.
Lag et terraform-script som setter følgende opp i ressursgruppen:
1. 
2. En App Service plan
   * kind = "Linux"
   * sku tier "Basic"
   * sku size "B1"
3. En App Service som bruker denne app-plan:
   * appSettings: "DOCKER_REGISTRY_SERVER_URL" = "https://ghcr.io"
   * linux_fx_version = "DOCKER|ghcr.io/sonat-consulting/swapi-dotnet:latest"

Opprett infrastrukturen med
```bash
$ terraform init
$ terraform plan -out state.tfplan
$ terraform apply state.tfplan
```

Når du har sjekket at det virker, kan du fjerne de opprettede ressurser igjen med:
```bash
$ terraform destroy
```


## Oppgave 2
1. Lag om på scriptet, slik at ressursgruppen ogsp blir opprettet av scriptet.
2. Lag et script som setter opp en Application Insights og en Log Analytics Workspace    
   Med samme oppsett for tilsvarende Bicep oppgave
3. Lag en variables.tf fil som beskriver følgende variabler:
   * App plan tier
   * App plan size
   * navn-prefix
4. Lag en tfvars-fil kalt "dev.tfvars", og legg inn ønskede verdier.

kjør scriptet med
```bash
$ terraform init
$ terraform plan -out state.tfplan -var-file dev.tfvars
$ terraform apply state.tfplan
```

rydd opp, og slett infrastrukturen med
```bash
$ terraform destroy -var-file dev.tfvars
```

## Oppgave 3
Hent inn secret fra key vault.
* Key vault heter `iac-common-kv` og ligger i `iac-common` ressursgruppen.
* Secret har key = `my-secret-value`
* Denne skal settes til appSettings verdien `Secrets__MySecret`

kjør scriptet med
```bash
$ terraform init
$ terraform plan -out state.tfplan -var-file dev.tfvars
$ terraform apply state.tfplan
```

rydd opp, og slett infrastrukturen med
```bash
$ terraform destroy -var-file dev.tfvars
```