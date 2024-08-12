variable "do_token" {
  description = "DigitalOcean access token"
  type = string
  sensitive = true
}

variable "ssh_key_path" {
  description = "Path to the SSH private key used to connect to the droplets. This will be used by ansible."
  type = string
}

variable "freeipa_admin_password" {
  description = "Password for the FreeIPA admin user"
  type = string
  sensitive = true
}

variable "freeipa_directory_manager_password" {
  description = "Password for the FreeIPA directory manager user"
  type = string
  sensitive = true
}