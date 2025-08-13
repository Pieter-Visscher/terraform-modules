terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
      version = "1.86.2"
    }
    time = {
      source = "hashicorp/time"
      version = "~> 0.7"
    }
  }
}
