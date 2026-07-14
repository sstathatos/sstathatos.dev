#!/usr/bin/env bash
# Install k3s on a cluster node. Run on the node itself, over SSH.
#
#   Control plane:  install-k3s.sh server <private-ip> [public-ip]
#                   (public-ip goes into the API cert SANs so local kubectl
#                   can connect through the admin firewall rule)
#   Worker:         install-k3s.sh agent  <private-ip> <server-private-ip> <token>
#
# All cluster traffic (API 6443, flannel VXLAN 8472, kubelet 10250) stays on
# the Hetzner private network — the public interface only ever sees 22/80/443,
# matching the Terraform firewalls. The token for joining agents is at
# /var/lib/rancher/k3s/server/node-token on the control plane.
set -euo pipefail

K3S_CHANNEL="${K3S_CHANNEL:-stable}"

role="${1:?usage: install-k3s.sh server|agent <private-ip> [server-private-ip] [token]}"
private_ip="${2:?missing node private IP}"

# The private network attaches as a second interface; find it by the IP
# Terraform assigned rather than assuming a device name.
iface="$(ip -o -4 addr show | awk -v ip="$private_ip" '$4 ~ ip"/" {print $2; exit}')"
[[ -n "$iface" ]] || { echo "no interface holds $private_ip — is the node attached to the private network?" >&2; exit 1; }

case "$role" in
server)
  # Traefik is replaced by ingress-nginx (deployed via ArgoCD); servicelb by
  # hostPort on the ingress controller.
  public_ip="${3:-}"
  curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL="$K3S_CHANNEL" sh -s - server \
    --node-ip "$private_ip" \
    --advertise-address "$private_ip" \
    --flannel-iface "$iface" \
    ${public_ip:+--tls-san "$public_ip"} \
    --disable traefik \
    --disable servicelb \
    --write-kubeconfig-mode 600
  echo "join token: $(cat /var/lib/rancher/k3s/server/node-token)"
  ;;
agent)
  server_ip="${3:?missing control-plane private IP}"
  token="${4:?missing join token}"
  curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL="$K3S_CHANNEL" K3S_URL="https://${server_ip}:6443" K3S_TOKEN="$token" sh -s - agent \
    --node-ip "$private_ip" \
    --flannel-iface "$iface"
  ;;
*)
  echo "unknown role: $role (want server|agent)" >&2
  exit 1
  ;;
esac
