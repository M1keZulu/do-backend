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

resource "azurerm_resource_group" "temprsg" {
  name     = "temprsg"
  location = "East US"
}

resource "azurerm_storage_account" "tempsag" {
  name                     = "tempsag"
  resource_group_name      = azurerm_resource_group.temprsg.name
  location                 = azurerm_resource_group.temprsg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tempcon" {
  name                  = "tempcon"
  storage_account_name  = azurerm_storage_account.tempsag.name
  container_access_type = "private"
}

resource "azurerm_container_registry" "tempreg" {
  name                     = "tempreg"
  resource_group_name      = azurerm_resource_group.temprsg.name
  location                 = azurerm_resource_group.temprsg.location
  sku                      = "Basic"
  admin_enabled            = true
}
