output "public_ip" {
  description = "DigitalOcean droplet IP address"
  value       = digitalocean_droplet.droplet.ipv4_address
}
