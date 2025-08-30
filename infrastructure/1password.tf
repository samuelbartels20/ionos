resource "onepassword_item" "ionos_credentials" {
  vault    = "K8s"
  title    = "ionos"
  category = "login"
  
  username = var.IONOS_USERNAME
  password = var.IONOS_PASSWORD
}

resource "onepassword_item" "ionos_all" {
  vault    = "K8s"
  title    = "ionos-config"
  category = "login"
  
  username = var.IONOS_USERNAME
  password = var.IONOS_PASSWORD

  section {
    label = "api_config"
    
    field {
      label = "endpoint"
      type  = "STRING"
      value = var.IONOS_ENDPOINT
    }
    
    field {
      label = "token"
      type  = "CONCEALED"
      value = var.TF_VAR_IONOS_TOKEN
    }
  }
}

resource "onepassword_item" "ionos_token" {

  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.IONOS_USERNAME
  password = var.TF_VAR_IONOS_TOKEN
}

resource "onepassword_item" "ionos_endpoint" {

  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.IONOS_USERNAME
  password = var.IONOS_PASSWORD

  section {
    label = "ionos_endpoint"
    
    field {
      label = "endpoint"
      type  = "STRING"
      value = data.onepassword_item.ionos_endpoint.IONOS_ENDPOINT
    }
  }
}

resource "onepassword_item" "ionos_username" {
  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.IONOS_USERNAME
  password = var.IONOS_PASSWORD

  section {
    label = "ionos_username"
    
    field {
      label = "endpoint"
      type  = "STRING"
      value = data.onepassword_item.ionos_username.IONOS_USERNAME
    }
  }
}

resource "onepassword_item" "ionos_password" {
  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.IONOS_USERNAME
  password = var.IONOS_PASSWORD

  section {
    label = "ionos_password"
    
    field {
      label = "password"
      type  = "STRING"
      value = data.onepassword_item.ionos_password.IONOS_PASSWORD
    }
  }
}

