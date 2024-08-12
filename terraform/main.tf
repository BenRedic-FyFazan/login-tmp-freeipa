data "digitalocean_domain" "login" {
  name = "login.no"
}

locals {
  freeipa_name = "ldap-new-tmp"
  freeipa_fqdn = "${local.freeipa_name}.${data.digitalocean_domain.login.name}"
}

resource "digitalocean_droplet" "freeipa" {
  image  = "centos-stream-9-x64"
  name   = local.freeipa_fqdn
  region = "ams3"
  size   = "s-4vcpu-8gb"
  ssh_keys = ["42195687", "39244674", "43045196"]
}

resource "digitalocean_record" "ldap_tmp_login_no" {
    domain = data.digitalocean_domain.login.id
    type = "A"
    name = local.freeipa_name
    ttl = 1800
    value = digitalocean_droplet.freeipa.ipv4_address
}

resource "ansible_host" "freeipa" {
  name   = digitalocean_droplet.freeipa.name
  groups = ["ipaserver"]
  variables = {
    # Connection variables
    ansible_user = "root"
    ansible_host            = digitalocean_droplet.freeipa.ipv4_address
    ansible_ssh_common_args = "-o StrictHostKeyChecking=no -i ${var.ssh_key_path}"

    # Freeipa variables
    freeipa_fqdn = local.freeipa_fqdn
    ipaadmin_password = var.freeipa_admin_password
    ipadm_password = var.freeipa_directory_manager_password
    ipaserver_domain = data.digitalocean_domain.login.name
    ipaserver_realm = upper(data.digitalocean_domain.login.name)

  }
}