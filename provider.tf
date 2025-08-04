terraform {
   required_providers {
     aws = {
         source = "hashicorp/aws"
         version = "3.0.0"
     }
   }
}

provider "aws" {
    region = "ap-south-1"
}

    provider "azurerm" {
      subscription_id = "your-azure-subscription-id"
      client_id = "your-azure-client-id"
         client_secret = "your-azure-client-secret"
         tenant_id = "your-azure-tenant-id"
          }
    
    
