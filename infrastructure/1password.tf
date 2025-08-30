resource "onepassword_item" "ionos_endpoint" {

  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.ionos_username
  password = var.ionos_password

  section {
    label = "ionos_endpoint"
    
    field {
      label = "IONOS_ENDPOINT"
      type  = "STRING"
      value = data.onepassword_item.ionos.IONOS_ENDPOINT
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
      label = "IONOS_USERNAME"
      type  = "STRING"
      value = data.onepassword_item.ionos.IONOS_USERNAME
    }
  }
}
resource "onepassword_item" "ionos_password" {
  vault    = "K8s"
  title    = "ionos"
  category = "login"
  
  section {
    label = "IONOS_PASSWORD"
    
    field {
      label = "IONOS_PASSWORD"
      value = data.onepassword_item.ionos.IONOS_PASSWORD
      type  = "CONCEALED"
    }
  }
}

resource "onepassword_item" "ionos_token" {
  vault    = "K8s"
  title    = "ionos"
  category = "login"
  
  section {
    label = "IONOS_TOKEN"
    
    field {
      label = "IONOS_TOKEN"
      value = data.onepassword_item.ionos.IONOS_TOKEN
      type  = "CONCEALED"
    }
  }
}