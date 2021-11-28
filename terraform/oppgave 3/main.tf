terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.85.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

data "azurerm_resource_group" "swapi_rg" {
  name = var.rg
}

data "azurerm_key_vault" "common_kv" {
  name = "iac-common-kv"
  resource_group_name = "iac-common"
}

data "azurerm_key_vault_secret" "my_app_secret" {
  name = "my-secret-value"
  key_vault_id = data.azurerm_key_vault.common_kv.id
}