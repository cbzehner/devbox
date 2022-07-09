provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  default = "60c29b921f9c422fea9c2680bb845cb4"
}

variable "domain" {}

resource "cloudflare_record" "apex" {
  zone_id = var.cloudflare_zone_id
  name    = "@" # root record signifier
  value   = digitalocean_droplet.production.ipv4_address
  type    = "A"
  proxied = false # proxy prevents ssh access
}

resource "cloudflare_record" "apex-www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = var.domain
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "wildcard" {
  zone_id = var.cloudflare_zone_id
  name    = "*"
  value   = var.domain
  type    = "CNAME"
  proxied = false
}
