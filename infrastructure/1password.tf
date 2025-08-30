
resource "onepassword_item" "ionos_endpoint" {

  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.ionos_username
  password = var.ionos_password

  section {
    label = "ionos_endpoint"
    
    field {
      label = "endpoint"
      type  = "STRING"
      value = data.onepassword_item.ionos_endpoint.fields.IONOS_ENDPOINT
    }
  }
}

resource "onepassword_item" "ionos_username" {
  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.ionos_username
  password = var.ionos_password

  section {
    label = "ionos_username"
    
    field {
      label = "endpoint"
      type  = "STRING"
      value = data.onepassword_item.ionos_username.fields.IONOS_USERNAME
    }
  }
}
resource "onepassword_item" "ionos_password" {
  vault    = "K8s"
  title    = "ionos"
  category = "login"
  
  section {
    label = "ionos_password"
    
    field {
      label = "IONOS_PASSWORD"
      value = data.onepassword_item.ionos_password.fields.IONOS_PASSWORD
      type  = "CONCEALED"
    }
  }
}

resource "onepassword_item" "ionos_token" {
  vault    = "K8s"
  title    = "ionos"
  category = "login"
  
  section {
    label = "ionos_token"
    
    field {
      label = "IONOS_TOKEN"
      value = data.onepassword_item.ionos_token.fields.IONOS_TOKEN
      type  = "CONCEALED"
    }
  }
}