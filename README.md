<div align="center">

<img src="https://avatars.githubusercontent.com/u/14830?v=4" align="left" width="144px" height="144px"/>

## My Home Operations repository

_... managed by Flux, Renovate and GitHub Actions_ :robot:

</div>

<div align="center">

[![k8s@home](https://img.shields.io/badge/-%20k8s%40home-blue?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/k8s-at-home)
[![selfhosted.show](https://img.shields.io/badge/-%20self--hosted-orange?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/U3Gvr54VRp)
[![Kubernetes](https://img.shields.io/badge/v1.26-blue?style=for-the-badge&logo=kubernetes&logoColor=white)](https://www.talos.dev/)
[![Documentation](https://img.shields.io/badge/documentation-green?&style=for-the-badge)][0]


</div>
<br><br>

👋 Welcome to my Home Operations repository. This is a mono repository for my home office infrastructure. I try to adhere to Infrastructure as Code (IaC) and GitOps practices using the tools like [Ansible](https://www.ansible.com/), [Terraform](https://www.terraform.io/), [Kubernetes](https://kubernetes.io/), [Flux](https://github.com/fluxcd/flux2), [Renovate](https://github.com/renovatebot/renovate) and [GitHub Actions](https://github.com/features/actions).

Also check out [ramblurr/nixcfg](https://github.com/ramblurr/nixcfg) for my NixOS configuration for various hosts.

---

### 📖 Docs

The documentation that goes along with this repo can be found [in my HomeOps docs][0].

---
## ☁️ Cloud Dependencies

While most of my infrastructure and workloads are selfhosted I do rely upon the cloud for certain key parts of my setup. This saves me from having to worry about two things. (1) Dealing with chicken/egg scenarios and (2) services I critically need whether my cluster is online or not.

The alternative solution to these two problems would be to host a Kubernetes cluster in the cloud and deploy applications like [HCVault](https://www.vaultproject.io/), [Vaultwarden](https://github.com/dani-garcia/vaultwarden), [ntfy](https://ntfy.sh/), and [Gatus](https://gatus.io/). However, maintaining another cluster and monitoring another group of workloads is a lot more time and effort than I am willing to put in.

| Service                                      | Use                                                                        | Cost           |
|----------------------------------------------|----------------------------------------------------------------------------|----------------|
| [1Password](https://1password.com/)          | Family Plan. Secrets with [External Secrets](https://external-secrets.io/) | ~$72/yr        |
| [Cloudflare](https://www.cloudflare.com/)    | DNS management, Argo Tunnels and R2                                        | ~$30/yr        |
| [GitHub](https://github.com/)                | Hosting this repository and continuous integration/deployments             | Free           |
| [Migadu](https://migadu.com/)                | Email hosting, personal, family, and business                              | ~$90/yr        |
| [NextDNS](https://nextdns.io/)               | My downstream DNS server which includes AdBlocking                           | ~$20/yr        |
| [Pushover](https://pushover.net/)            | Kubernetes Alerts and application notifications                            | Free           |
| [Terraform Cloud](https://www.terraform.io/) | Storing Terraform state                                                    | Free           |
|                                              |                                                                            | Total: ~$18/mo |
---
## ⛵ Kubernetes

There is a template over at [onedr0p/flux-cluster-template](https://github.com/onedr0p/flux-cluster-template) if you wanted to try and follow along with some of the practices I use here. Though my setup is custom and doesn't follow the template that closely.

### Installation

My cluster is [Talos](https://www.talos.dev/) provisioned overtop my Proxmox
cluster. This is a semi hyper-converged cluster, workloads and block storage
are sharing the same available resources on my nodes while I have a [separate
NAS](https://notes.binaryelysium.com/HomeOps/NAS/) for (NFS) file storage.

🔸 _[Click here](./ansible/) to see my Ansible playbooks and roles._

### Core Components

- [actions-runner-controller](https://github.com/actions/actions-runner-controller): self-hosted Github runners
- [cilium](https://github.com/cilium/cilium): internal Kubernetes networking plugin
- [cert-manager](https://cert-manager.io/docs/): creates SSL certificates for services in my cluster
- [external-dns](https://github.com/kubernetes-sigs/external-dns): automatically syncs DNS records from my cluster ingresses to a DNS provider
- [external-secrets](https://github.com/external-secrets/external-secrets/): managed Kubernetes secrets using [1Password Connect](https://github.com/1Password/connect).
- [ingress-nginx](https://github.com/kubernetes/ingress-nginx/): ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer
- [rook](https://github.com/rook/rook): distributed block storage for persistent storage. I use a Ceph cluster external to the cluster, running on Proxmox.
- [sops](https://toolkit.fluxcd.io/guides/mozilla-sops/): managed secrets for Kubernetes, Ansible and Terraform which are commited to Git
- [volsync](https://github.com/backube/volsync) and [snapscheduler](https://github.com/backube/snapscheduler): backup and recovery of persistent volume claims
### GitOps

[Flux](https://github.com/fluxcd/flux2) watches my [k8s/k8s-prod](./k8s/k8s-prod/) folder (see Directories below) and makes the changes to my cluster based on the YAML manifests.

The way Flux works for me here is it will recursively search the
[k8s/k8s-prod/workloads](./k8s/k8s-prod/workloads) folder until it finds the
most top level `kustomization.yaml` per directory and then apply all the
resources listed in it. That aforementioned `kustomization.yaml` will generally
only have a namespace resource and one or many Flux kustomizations. Those Flux
kustomizations will generally have a `HelmRelease` or other resources related to
the application underneath it which will be applied.

[Renovate](https://github.com/renovatebot/renovate) watches my **entire**
repository looking for dependency updates, when they are found a PR is
automatically created. When some PRs are merged
[Flux](https://github.com/fluxcd/flux2) applies the changes to my cluster.

### Directories

This Git repository contains the following directories under [kubernetes](./kubernetes/).

```sh
📁 k8s/k8s-prod    # Kubernetes cluster defined as code
├─📁 bootstrap     # Flux installation
├─📁 flux          # Main Flux configuration of repository
└─📁 workloads     # Apps deployed into my cluster grouped by namespace
```
---
## 🌐 DNS

### Home DNS

I have two Raspberry PI 3s running CoreDNS that serve as the main DNS provider for my network. In my k8s cluster `external-dns` is deployed with the `RFC2136` provider which syncs DNS records to `bind9`.

For downstream DNS I use [NextDNS](https://nextdns.io/) which provides adblocking.

### Public DNS

Outside the `external-dns` instance mentioned above another instance is deployed
in my cluster and configure to sync DNS records to
[Cloudflare](https://www.cloudflare.com/). The only ingresses this
`external-dns` instance looks at to gather DNS records to put in `Cloudflare`
are ones that have an ingress class name of `external` and an ingress annotation
of `external-dns.alpha.kubernetes.io/target`.

---

### :handshake: Thanks

Thanks to all the people who donate their time to the [Kubernetes @Home](https://discord.gg/k8s-at-home) Discord community. A lot of inspiration for my cluster comes from the people that have shared their clusters using the [k8s-at-home](https://github.com/topics/k8s-at-home) GitHub topic. Be sure to check out the [Kubernetes @Home search](https://nanne.dev/k8s-at-home-search/) for ideas on how to deploy applications or get ideas on what you can deploy.

And also a big thanks to the great community from the [Self-Hosted Podcast](https://www.jupiterbroadcasting.com/show/self-hosted/) (and Jupiter Broadcasting in general!). It's a friendly community of FOSS, Linux, Self-Hosting advocates.


---

### 🔏 License

Different parts of this repo have different licenses. Refer to the LICENSE file in the various subdirectories.

[0]: https://notes.binaryelysium.com/HomeOps/
