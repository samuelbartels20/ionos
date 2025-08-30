data "onepassword_item" "ionos_username" {
  vault = "K8S"
  title = "ionos"
}

data "onepassword_item" "ionos_password" {
  vault = "K8S"
  title = "ionos"
}

data "onepassword_item" "ionos_endpoint" {
  vault = "K8S"
  title = "ionos"
}

data "onepassword_item" "ionos_token" {
  vault = "K8S"
  title = "ionos"
}


data "onepassword_vault" "k8s" {
  name = "K8S"
}

data "onepassword_item" "ionos" {
  vault = data.onepassword_vault.k8s.id
  title = "ionos"
}
