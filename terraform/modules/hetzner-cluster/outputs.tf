output "nodes" {
  description = "Node name → public IPv4, private IP, and role"
  value = {
    for name, node in hcloud_server.node : name => {
      public_ip  = node.ipv4_address
      private_ip = hcloud_server_network.node[name].ip
      role       = var.nodes[name].role
    }
  }
}

output "ingress_public_ip" {
  description = "Public IPv4 of the node serving 80/443 (DNS target)"
  value       = one([for name, node in hcloud_server.node : node.ipv4_address if var.nodes[name].role == "server"])
}

output "network_id" {
  value = hcloud_network.cluster.id
}
