terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.50"
    }
  }
}

# Servers were bought manually and are imported into state (see import blocks
# in the environment). Attributes that would force a rebuild of a running
# server are ignored — Terraform manages the surrounding infrastructure
# (network, firewalls, DNS), not the machine lifecycle itself.
resource "hcloud_server" "node" {
  for_each = var.nodes

  name        = each.key
  server_type = each.value.server_type
  location    = each.value.location
  image       = var.image

  labels = {
    cluster = "sstathatos"
    role    = each.value.role
  }

  lifecycle {
    ignore_changes  = [image, ssh_keys, user_data, keep_disk]
    prevent_destroy = true
  }
}

resource "hcloud_network" "cluster" {
  name     = "sstathatos-cluster"
  ip_range = var.network_cidr
}

resource "hcloud_network_subnet" "nodes" {
  network_id   = hcloud_network.cluster.id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = var.subnet_cidr
}

# k3s traffic (API 6443, flannel VXLAN 8472, kubelet 10250) flows over this
# private network. Hetzner firewalls only filter the public interface, so no
# inter-node rules are needed.
resource "hcloud_server_network" "node" {
  for_each = var.nodes

  server_id  = hcloud_server.node[each.key].id
  network_id = hcloud_network.cluster.id
  ip         = each.value.private_ip

  depends_on = [hcloud_network_subnet.nodes]
}

resource "hcloud_firewall" "base" {
  name = "sstathatos-base"

  rule {
    description = "SSH from admin IPs only"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = var.admin_ssh_ips
  }

  rule {
    description = "kubernetes API from admin IPs (local kubectl)"
    direction   = "in"
    protocol    = "tcp"
    port        = "6443"
    source_ips  = var.admin_ssh_ips
  }

  rule {
    description = "ICMP"
    direction   = "in"
    protocol    = "icmp"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_firewall" "ingress" {
  name = "sstathatos-ingress"

  rule {
    description = "HTTP"
    direction   = "in"
    protocol    = "tcp"
    port        = "80"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }

  rule {
    description = "HTTPS"
    direction   = "in"
    protocol    = "tcp"
    port        = "443"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_firewall_attachment" "base" {
  firewall_id = hcloud_firewall.base.id
  server_ids  = [for node in hcloud_server.node : node.id]
}

# Only the control-plane node serves public 80/443 (ingress-nginx runs there).
resource "hcloud_firewall_attachment" "ingress" {
  firewall_id = hcloud_firewall.ingress.id
  server_ids  = [for name, node in hcloud_server.node : node.id if var.nodes[name].role == "server"]
}
