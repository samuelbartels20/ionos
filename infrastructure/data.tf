data "onepassword_vault" "K8s" {
  name = "K8s"
}

data "onepassword_item" "item" {
  vault = data.onepassword_vault.K8s.name
  title = "ionos"
}

