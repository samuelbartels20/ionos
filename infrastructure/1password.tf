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
      value = var.ionos_endpoint
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
      value = var.ionos_username
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
      value = var.ionos_password
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
      value = var.ionos_token
      type  = "CONCEALED"
    }
  }
}