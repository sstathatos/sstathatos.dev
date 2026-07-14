terraform {
  # Import blocks with for_each need 1.7+.
  required_version = ">= 1.7"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.50"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# Token comes from HCLOUD_TOKEN in the environment.
provider "hcloud" {}

# Token comes from CLOUDFLARE_API_TOKEN in the environment (Zone.DNS edit
# scope). Unused until manage_dns = true.
provider "cloudflare" {}

module "cluster" {
  source = "../modules/hetzner-cluster"

  nodes         = var.nodes
  admin_ssh_ips = var.admin_ssh_ips
}
