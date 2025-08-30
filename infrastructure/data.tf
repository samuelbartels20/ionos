data "onepassword_item" "IONOS_USERNAME" {
  vault = "K8S"
  title = "ionos"
}

data "onepassword_item" "IONOS_PASSWORD" {
  vault = "K8S"
  title = "ionos"
}

data "onepassword_item" "IONOS_ENDPOINT" {
  vault = "K8S"
  title = "ionos"
}


data "onepassword_item" "TF_VAR_IONOS_TOKEN" {
  vault = "K8S"
  title = "ionos"
}

