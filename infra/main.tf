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

resource "azurerm_resource_group" "example-group" {
  name     = "example-group"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "tempkube"
  location            = azurerm_resource_group.temprsg.location
  resource_group_name = azurerm_resource_group.temprsg.name
  dns_prefix          = "tempkube" // Replace with your preferred DNS prefix
  kubernetes_version  = "1.21.4"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2" // Choose the appropriate VM size
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    environment = "production"
  }
}
