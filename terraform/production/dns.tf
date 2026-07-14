# Cloudflare DNS for sstathatos.dev. Inactive until the domain is bought on
# Cloudflare Registrar — set manage_dns = true (and CLOUDFLARE_API_TOKEN in
# the environment) once the zone exists.
#
# Both records are proxied: Cloudflare terminates TLS at the edge, caches
# static assets, and hides the VPS IP.

data "cloudflare_zone" "site" {
  count = var.manage_dns ? 1 : 0
  name  = var.domain
}

resource "cloudflare_record" "apex" {
  count = var.manage_dns ? 1 : 0

  zone_id = data.cloudflare_zone.site[0].id
  name    = "@"
  type    = "A"
  content = module.cluster.ingress_public_ip
  proxied = true
}

resource "cloudflare_record" "grafana" {
  count = var.manage_dns ? 1 : 0

  zone_id = data.cloudflare_zone.site[0].id
  name    = "grafana"
  type    = "A"
  content = module.cluster.ingress_public_ip
  proxied = true
}
