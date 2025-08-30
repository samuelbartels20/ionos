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
      value = var.IONOS_TOKEN
    }
  }
}

resource "onepassword_item" "ionos_token" {

  vault = "K8s"
  title = "ionos"
  category = "login"
  
  username = var.IONOS_USERNAME
  password = var.IONOS_TOKEN
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
      value = var.IONOS_ENDPOINT
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
      value = var.IONOS_USERNAME
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
      value = var.IONOS_PASSWORD
    }
  }
}


resource "onepassword_item" "ionos_endpoint" {
  vault    = "K8s"
  title    = "ionos"
  category = "login"
  
  section {
    label = "ionos_endpoint"
    
    field {
      label = "IONOS_ENDPOINT"
      value = var.IONOS_ENDPOINT
      type  = "CONCEALED"
    }
  }
}

# Similar fixes for your other onepassword_item resources
resource "onepassword_item" "ionos_username" {
  vault    = "K8s"
  title    = "ionos"
  category = "login"
  
  section {
    label = "ionos_username"
    
    field {
      label = "IONOS_USERNAME"
      value = var.IONOS_USERNAME
      type  = "CONCEALED"
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
      value = var.IONOS_PASSWORD
      type  = "CONCEALED"
    }
  }
}