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

resource "cloudflare_record" "mail-exchanger-one" {
  zone_id  = var.cloudflare_zone_id
  name     = "@"
  value    = "in1-smtp.messagingengine.com"
  priority = 10
  type     = "MX"
  proxied  = false
}

resource "cloudflare_record" "mail-exchanger-two" {
  zone_id  = var.cloudflare_zone_id
  name     = "@"
  value    = "in2-smtp.messagingengine.com"
  priority = 20
  type     = "MX"
  proxied  = false
}

resource "cloudflare_record" "verify-ownership-for-fastmail-one" {
  zone_id = var.cloudflare_zone_id
  name    = "fm1._domainkey"
  value   = "fm1.commitracer.com.dkim.fmhosted.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "verify-ownership-for-fastmail-two" {
  zone_id = var.cloudflare_zone_id
  name    = "fm2._domainkey"
  value   = "fm2.commitracer.com.dkim.fmhosted.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "verify-ownership-for-fastmail-three" {
  zone_id = var.cloudflare_zone_id
  name    = "fm3._domainkey"
  value   = "fm3.commitracer.com.dkim.fmhosted.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "sender-policy-framework" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "dmarc" {
  zone_id = var.cloudflare_zone_id
  name    = "_dmarc"
  value   = "v=DMARC1; p=quarantine; rua=mailto:admin@commitracer.com"
  type    = "TXT"
  proxied = false
}
