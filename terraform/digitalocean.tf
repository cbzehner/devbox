variable "digitalocean_access_token" {
  sensitive = true
}

provider "digitalocean" {
  token = var.digitalocean_access_token
}

resource "digitalocean_droplet" "droplet" {
  image     = "debian-11-x64"
  name      = var.domain
  region    = "nyc3"
  size      = "s-1vcpu-1gb"
  user_data = file("cloud-init.yaml")
  ssh_keys = [
    data.digitalocean_ssh_key.root_user.id
  ]
}

# Automatically deploy the public key from Digital Ocean to this machine.
data "digitalocean_ssh_key" "root_user" {
  name = "root@${var.domain} SSH public key"
}
