data "onepassword_vault" "vault" {
  name = var.vault
}

data "onepassword_item" "item" {
  vault = data.onepassword_vault.vault.name
  title = var.item
}