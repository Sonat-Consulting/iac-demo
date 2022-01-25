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

