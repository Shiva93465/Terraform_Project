# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
  }

# Configure the Microsoft Azure Provider
provider "azurerm" { # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  subscription_id = "5eed5e9f-f0a9-44e7-b3c4-c02cbb50d9a7"
}

# Create a resource group
resource "azurerm_resource_group" "rgTF1" {
name = "shivargTF1"
location = "eastus"
tags = {
  earn = "money"
}
}

resource "azurerm_resource_group" "rgTF2" {
    name = "shivargTF2"
    location = "EastUS"
    tags = {
      environ = "Prod"
      owner = "shiva"
    }
}

resource "azurerm_resource_group" "rgTF4" {
    name = "shivargTF4"
    location = "EastUS"
    tags = {
      environ = "COB"
    }
}

resource "azurerm_storage_account" "Strgacc01" {
    name = "shivastrgacc01"
    resource_group_name = azurerm_resource_group.rgTF1.name
    location = "EastUS"
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    access_tier = "Hot"
    public_network_access_enabled = "true"
}