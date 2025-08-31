resource "onepassword_item" "ionos_endpoint" {

  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
  category = "login"
  
  username = data.onepassword_item.IONOS_USERNAME.IONOS_USERNAME
  password = data.onepassword_item.IONOS_PASSWORD.IONOS_PASSWORD

  section {
    label = "ionos_endpoint"
    
    field {
      label = "ionos_endpoint"
      type  = "STRING"
      value = data.onepassword_item.IONOS_ENDPOINT.IONOS_ENDPOINT
    }
  }
}

resource "onepassword_item" "ionos_username" {
  vault = "xyrzokprou45dsa55meaoieqci"
  title = "ionos"
  category = "login"
  
  username = data.onepassword_item.IONOS_USERNAME.IONOS_USERNAME
  password = data.onepassword_item.IONOS_PASSWORD.IONOS_PASSWORD

  section {
    label = "ionos_username"
    
    field {
      label = "ionos_username"
      type  = "STRING"
      value = data.onepassword_item.IONOS_USERNAME.IONOS_USERNAME
    }
  }
}
resource "onepassword_item" "ionos_password" {
  vault    = "xyrzokprou45dsa55meaoieqci"
  title    = "ionos"
  category = "login"
  
  section {
    label = "ionos_password"
    
    field {
      label = "ionos_password"
      value = data.onepassword_item.IONOS_PASSWORD.IONOS_PASSWORD
      type  = "CONCEALED"
    }
  }
}

resource "onepassword_item" "ionos_token" {
  vault    = "xyrzokprou45dsa55meaoieqci"
  title    = "ionos"
  category = "login"
  
  section {
    label = "ionos_token"
    
    field {
      label = "ionos_token"
      value = data.onepassword_item.IONOS_TOKEN.IONOS_TOKEN
      type  = "CONCEALED"
    }
  }
}