  provider "vault" {
    address = "http://vault-int.vdevops.io:8200"
  }

  resource "vault_mount" "kv" {
    for_each    = var.secrets
    path        = each.key
    type        = "kv"
    options     = { version = "2" }
    description = each.value["description"]
  }

  resource "vault_kv_secret_v2" "values" {
    for_each            = var.values
    mount               = each.value["secret"]
    name                = each.key
    data_json_wo = jsonencode(each.value["value"])
  }