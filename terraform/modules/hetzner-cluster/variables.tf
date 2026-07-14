variable "nodes" {
  description = "Existing Hetzner servers forming the k3s cluster, keyed by node name"
  type = map(object({
    server_id   = number
    server_type = string
    location    = string
    role        = string # "server" (control plane) or "agent" (worker)
    private_ip  = string
  }))

  validation {
    condition     = length([for n in var.nodes : n if n.role == "server"]) == 1
    error_message = "Exactly one node must have role \"server\"."
  }
}

variable "image" {
  description = "OS image the servers were created with (kept only so config matches reality)"
  type        = string
  default     = "ubuntu-24.04"
}

variable "network_cidr" {
  description = "CIDR of the private network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR of the subnet the nodes join"
  type        = string
  default     = "10.0.1.0/24"
}

variable "network_zone" {
  description = "Hetzner network zone (eu-central for Falkenstein/Nuremberg/Helsinki)"
  type        = string
  default     = "eu-central"
}

variable "admin_ssh_ips" {
  description = "CIDRs allowed to reach SSH on the public interface"
  type        = list(string)
}
