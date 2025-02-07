# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "shivargTF1"
    storage_account_name  = "shivastrgacc01"
    container_name        = "mytfstatecontainer"
    key                   = "Shiva.tfstate"
    
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

resource "azurerm_virtual_machine" "Vm01" {
    name = "shivaVM01"
    resource_group_name   = "shivargTF1"
    location = "EastUS"
    vm_size = "Standard_DS1_v2"
    delete_os_disk_on_termination = "true"
    delete_data_disks_on_termination = "true"
    storage_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "16.04-LTS"
      version = "latest"
    }
    storage_os_disk {
      name = "myOsDisk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile {
      computer_name = "shivaVM01"
      admin_username = "shiva"
      admin_password = "Kalki2898@431"
    }
    os_profile_linux_config {
      disable_password_authentication = false
    }
    network_interface_ids = [azurerm_network_interface.nic01.id]
}
resource "azurerm_network_interface" "nic01" {
    name = "shivaNIC01"
    resource_group_name = "shivargTF1"
    location = "EastUS"
    ip_configuration {
      name = "shivaNIC01"
      subnet_id = azurerm_subnet.subnet01.id
      private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_subnet" "subnet01" {
    name = "shivaSubnet01"
    resource_group_name = "shivargTF1"
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network" "vnet01" {
    name = "shivaVnet01"
    resource_group_name = "shivargTF1"
    location = "EastUS"
    address_space = ["10.0.0.0/16"]
    dns_servers = []
}