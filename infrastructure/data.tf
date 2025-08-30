data "onepassword_item" "ionos_username" {
  vault = "K8s"
  title = "ionos"
}

data "onepassword_item" "ionos_password" {
  vault = "K8s"
  title = "ionos"
}

data "onepassword_item" "ionos_endpoint" {
  vault = "K8s"
  title = "ionos"
}

data "onepassword_item" "ionos_token" {
  vault = "K8s"
  title = "ionos"
}


data "onepassword_vault" "K8s" {
  name = "K8s"
}

data "onepassword_item" "ionos" {
  vault = data.onepassword_vault.K8s.id
  title = "ionos"
}
