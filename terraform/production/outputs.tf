output "nodes" {
  value = module.cluster.nodes
}

output "ingress_public_ip" {
  description = "Point the sstathatos.dev A record here"
  value       = module.cluster.ingress_public_ip
}
