data "onepassword_item" "ionos_username" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}

data "onepassword_item" "ionos_password" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}

data "onepassword_item" "ionos_endpoint" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}

data "onepassword_item" "ionos_token" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
}


data "onepassword_vault" "xyrzokprou45dsa55meaoieqci" {
  name = "xyrzokprou45dsa55meaoieqci"
}

data "onepassword_item" "ionos" {
  vault = data.onepassword_vault.xyrzokprou45dsa55meaoieqci.id
  title = "ionos"
}
