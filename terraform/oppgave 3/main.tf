terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.93.1"
    }
  }
  backend "azurerm" {
    resource_group_name = "iac-common"
    storage_account_name = "iacdemoterraformstate"
    container_name = "tfstate"
    key = "larsaaberg-terraform.tfstate" #Update this line!
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "swapi_rg" {
  name = var.rg
  location = var.location
}

data "azurerm_key_vault" "common_kv" {
  name = "iac-demo-common-kv"
  resource_group_name = "iac-common"
}

data "azurerm_key_vault_secret" "my_app_secret" {
  name = "my-secret-value"
  key_vault_id = data.azurerm_key_vault.common_kv.id
}