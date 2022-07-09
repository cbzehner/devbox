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

resource "cloudflare_record" "apex_record" {
  zone_id = var.cloudflare_zone_id
  name    = "@" # root record signifier
  value   = digitalocean_droplet.production.ipv4_address
  type    = "A"
  proxied = false # proxy prevents ssh access
}

resource "cloudflare_record" "internal" {
  zone_id = var.cloudflare_zone_id
  name    = "internal"
  value   = var.domain
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "development" {
  zone_id = var.cloudflare_zone_id
  name    = "*.dev"
  value   = var.domain
  type    = "CNAME"
  proxied = true
}
