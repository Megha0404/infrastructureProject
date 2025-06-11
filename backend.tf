# terraform {
#   backend "azurerm" {
#     resource_group_name  = "terraform-final-rg"           # Name of the resource group where the storage account exists
#     storage_account_name = "terraformfinalsa"   # Name of the storage account you created
#     container_name       = "tfstate"               # Name of the blob container
#     key                  = ""     # File name for the state file
#   }
# }