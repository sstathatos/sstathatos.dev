variable "nodes" {
  description = "Existing Hetzner servers forming the k3s cluster, keyed by node name"
  type = map(object({
    server_id   = number
    server_type = string
    location    = string
    role        = string
    private_ip  = string
  }))
}

variable "admin_ssh_ips" {
  description = "CIDRs allowed to reach SSH on the public interface"
  type        = list(string)
}

variable "domain" {
  type    = string
  default = "sstathatos.dev"
}

variable "manage_dns" {
  description = "Enable once the domain exists as a Cloudflare zone"
  type        = bool
  default     = false
}
