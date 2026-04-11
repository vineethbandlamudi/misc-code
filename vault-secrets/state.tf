provider "vault" {
  address = "http://vault-int.vdevops.io:8200"
  token   = var.token
}

terraform {
  backend "azurerm" {
    client_id            = "5eb15971-b7b2-4dff-8723-eb26f02b490f"
    client_secret        = ""
    tenant_id            = "35a369cc-1cfb-4274-b763-2745ea0e4940"
    subscription_id      = "721ea30a-1562-42c5-89d7-30aeb9ce9522"
    resource_group_name  = "project-setup"
    storage_account_name = "roboshopstorage"
    container_name       = "roboshopcontainer"
    key                  = "tools-terraform.tfstate"
  }
}