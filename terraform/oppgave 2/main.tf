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

