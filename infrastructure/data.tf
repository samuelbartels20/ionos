data "onepassword_vault" "K8s" {
  name = "K8s"
}

data "onepassword_item" "IONOS_USERNAME" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}

data "onepassword_item" "IONOS_PASSWORD" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}

data "onepassword_item" "IONOS_ENDPOINT" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}

data "onepassword_item" "IONOS_TOKEN" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}