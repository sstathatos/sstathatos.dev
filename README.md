# sstathatos.dev

Personal site and portfolio for Stefanos Stathatos — DevOps Engineer.

This repository is itself part of the portfolio: the site is a static
Astro build presenting my experience, and it's deployed on infrastructure
built entirely from this repo — Terraform-managed servers, a GitOps-driven
Kubernetes cluster, and a full CI/CD pipeline.

**Live:** https://sstathatos.dev

## What this is

Two things at once:

1. A personal site — experience, skills, certifications, contact.
2. A working example of the infrastructure practices described on it:
   infrastructure as code, GitOps deployment, and observability, all
   running on real servers rather than a slide deck.

## Stack

- **Hosting:** Hetzner Cloud, 2-node [k3s](https://k3s.io) cluster joined
  over a private network
- **IaC:** [Terraform](https://terraform.io) — servers, network, firewalls,
  and DNS all declared and imported into state
- **GitOps:** [ArgoCD](https://argo-cd.readthedocs.io), syncing every
  workload from this repository
- **Packaging:** [Helm](https://helm.sh) chart for the site
- **Ingress/TLS:** ingress-nginx + cert-manager (Let's Encrypt)
- **DNS/CDN:** Cloudflare
- **Site:** [Astro](https://astro.build), built as a Docker image
- **CI:** GitHub Actions — build, scan, publish
- **Observability:** Prometheus + Grafana

## Architecture

```
GitHub  →  GitHub Actions (build, scan, push image)
        →  ArgoCD (watches this repo, syncs to the cluster)

Hetzner — 2-node k3s cluster on a private network
 ├── control-plane node — ingress-nginx (80/443) + cert-manager
 ├── worker node
 ├── site — Astro, served behind ingress with a Let's Encrypt cert
 └── kube-prometheus-stack — Prometheus + Grafana
```

## Structure

| Directory     | Contents                                          |
|---------------|----------------------------------------------------|
| `terraform/`  | Hetzner infrastructure: servers, network, firewalls, DNS |
| `scripts/`    | Cluster bootstrap (k3s install)                    |
| `argocd/`     | ArgoCD application definitions                     |
| `helm/`       | Helm chart for the site                            |
| `site/`       | Astro site source                                  |
| `monitoring/` | Prometheus/Grafana configuration                   |
| `.github/`    | CI workflows                                        |

## Contact

- [GitHub](https://github.com/sstathatos)
- [LinkedIn](https://www.linkedin.com/in/stefanos-stathatos-43081016a/)
