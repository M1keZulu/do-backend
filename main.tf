terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.27.0"
    }
  }
  backend "azurerm" {
    resource_group_name = var.bkstrgrg
    storage_account_name = var.bkstrg
    container_name       = var.bkcontainer
    key                  = var.bkstrgkey
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

data "azurerm_resource_group" "existing" {
  name = "DO_Project"
}

data "azurerm_location" "existing" {
  name            = "DO_Project"
  resource_group_name = data.azurerm_resource_group.existing.name
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_location.existing.name
  resource_group_name = data.azurerm_resource_group.existing.name
}
