data "digitalocean_domain" "login" {
  name = "login.no"
}

resource "digitalocean_droplet" "freeipa" {
  image  = "centos-stream-9-x64"
  name   = "tmp-ipaserver"
  region = "ams3"
  size   = "s-4vcpu-8gb"
  ssh_keys = ["42195687", "39244674", "43045196"]
}

resource "digitalocean_record" "ldap_tmp_login_no" {
    domain = data.digitalocean_domain.login.id
    type = "A"
    name = "ldap-new-tmp"
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
    ipaadmin_password = var.freeipa_admin_password
    ipadm_password = var.freeipa_directory_manager_password
    ipaserver_domain = data.digitalocean_domain.login.name
    ipaserver_realm = upper(data.digitalocean_domain.login.name)

  }
}