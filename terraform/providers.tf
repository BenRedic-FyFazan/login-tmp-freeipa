terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.40.0"
    }
    ansible = {
      source = "ansible/ansible"
      version = "1.3.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

