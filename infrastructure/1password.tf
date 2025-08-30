
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
      label = "endpoint"
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
    label = "ionos_password"
    
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
    label = "ionos_token"
    
    field {
      label = "IONOS_TOKEN"
      value = var.ionos_token
      type  = "CONCEALED"
    }
  }
}