output "production_ip" {
  description = "Production IP address"
  value       = digitalocean_droplet.production.ipv4_address
}
