.ONESHELL:
.SHELLFLAGS += -e -o pipefail

export ROOT := $(realpath /home/ramblurr/src/home-ops/ansible/..)
export CLUSTER := "k8s-prod"
export TALOS_DIR := $(realpath /home/ramblurr/src/home-ops/ansible/../talos/k8s-prod)
export TALOS_IMAGE := "ghcr.io/siderolabs/installer:v1.4.8"
export K8S_DIR := $(realpath /home/ramblurr/src/home-ops/ansible/../k8s/k8s-prod)
export TALOSCONFIG := ${TALOS_DIR}/clusterconfig/talosconfig
export KUBECONFIG := ${TALOS_DIR}/kubeconfig

TC := talosctl --talosconfig ${TALOSCONFIG}
KC := kubectl
CP_IPS = 10.9.9.121 10.9.9.122 10.9.9.123 10.9.9.124 10.9.9.125
CP_ARGS = $(addprefix -n ,$(CP_IPS))
CP_ENDPOINT = 10.9.9.121
ARGS ?=
REAPPLY_MODE ?= staged

dist-clean:
	rm -rf clusterconfig/*.yaml clusterconfig/talosconfig kubeconfig talsecret.sops.yaml

talsecret.sops.yaml:
	talhelper gensecret > talsecret.sops.yaml
	sops -e -i talsecret.sops.yaml

gen: talsecret.sops.yaml
	talhelper genconfig

reset:
	${TC} reset --endpoints $(CP_ENDPOINT) --graceful=false $(CP_ARGS) --reboot --wait=false
	$(MAKE) dist-clean

first-apply:
	${TC} apply-config --insecure --nodes 10.9.9.121 --file clusterconfig/k8s-prod-cp0.yaml
	${TC} apply-config --insecure --nodes 10.9.9.122 --file clusterconfig/k8s-prod-cp1.yaml
	${TC} apply-config --insecure --nodes 10.9.9.123 --file clusterconfig/k8s-prod-cp2.yaml
	${TC} apply-config --insecure --nodes 10.9.9.124 --file clusterconfig/k8s-prod-cp3.yaml
	${TC} apply-config --insecure --nodes 10.9.9.125 --file clusterconfig/k8s-prod-cp4.yaml
	${TC} apply-config --insecure --nodes 10.9.9.130 --file clusterconfig/k8s-prod-wrk0.yaml
	${TC} apply-config --insecure --nodes 10.9.9.131 --file clusterconfig/k8s-prod-wrk1.yaml
	${TC} apply-config --insecure --nodes 10.9.9.132 --file clusterconfig/k8s-prod-wrk2.yaml
	${TC} apply-config --insecure --nodes 10.9.9.133 --file clusterconfig/k8s-prod-wrk3.yaml
	${TC} apply-config --insecure --nodes 10.9.9.134 --file clusterconfig/k8s-prod-wrk4.yaml

bootstrap:
	${TC} bootstrap --nodes 10.9.9.121

kubeconf:
	${TC} kubeconfig --nodes 10.9.9.121 -f .

# Shutdown all cps right away
shutdown-all:
	${TC} shutdown --wait \
	 --nodes 10.9.9.121 --nodes 10.9.9.122 --nodes 10.9.9.123 --nodes 10.9.9.124 --nodes 10.9.9.125 \
	 --nodes 10.9.9.130 --nodes 10.9.9.131 --nodes 10.9.9.132 --nodes 10.9.9.133 --nodes 10.9.9.134
# Reboots all cps right away
reboot-all-cp:
	${TC} reboot --wait \
	 --nodes 10.9.9.121 --nodes 10.9.9.122 --nodes 10.9.9.123 --nodes 10.9.9.124 --nodes 10.9.9.125
# Reboots all workers right away
reboot-all-workers:
	${TC} reboot --wait \
	 --nodes 10.9.9.130 --nodes 10.9.9.131 --nodes 10.9.9.132 --nodes 10.9.9.133 --nodes 10.9.9.134
# Reboots cp nodes one at a time
reboot-cp:
	${TC} reboot --wait --nodes 10.9.9.121
	${TC} reboot --wait --nodes 10.9.9.122
	${TC} reboot --wait --nodes 10.9.9.123
	${TC} reboot --wait --nodes 10.9.9.124
	${TC} reboot --wait --nodes 10.9.9.125

# Reboots worker nodes one at a time
reboot-workers:
	${TC} reboot --wait --nodes 10.9.9.130
	${TC} reboot --wait --nodes 10.9.9.131
	${TC} reboot --wait --nodes 10.9.9.132
	${TC} reboot --wait --nodes 10.9.9.133
	${TC} reboot --wait --nodes 10.9.9.134

reapply:
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.121 --file clusterconfig/k8s-prod-cp0.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.122 --file clusterconfig/k8s-prod-cp1.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.123 --file clusterconfig/k8s-prod-cp2.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.124 --file clusterconfig/k8s-prod-cp3.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.125 --file clusterconfig/k8s-prod-cp4.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.130 --file clusterconfig/k8s-prod-wrk0.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.131 --file clusterconfig/k8s-prod-wrk1.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.132 --file clusterconfig/k8s-prod-wrk2.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.133 --file clusterconfig/k8s-prod-wrk3.yaml $(ARGS)
	${TC} apply-config --mode ${REAPPLY_MODE} --nodes 10.9.9.134 --file clusterconfig/k8s-prod-wrk4.yaml $(ARGS)

apply-bootstrap-cni:
	${KC} kustomize --enable-helm ./cni | kubectl apply -f -
apply-bootstrap-csr-approver:
	${KC} kustomize --enable-helm ./kubelet-csr-approver | kubectl apply -f -

apply-extras: apply-bootstrap-csr-approver apply-bootstrap-ci

bootstrap-flux:
	cd $(K8S_DIR)
	$(KC) apply --server-side --kustomize ./bootstrap
	sops -d ./bootstrap/age-key.sops.yaml | $(KC) apply -f -
	sops -d ./bootstrap/github-deploy-key.sops.yaml | $(KC) apply -f -
	sops -d ./flux/vars/global-secrets.yaml | $(KC) apply -f -
	$(KC) apply -f ./flux/vars/global-vars.yaml
	$(KC) apply -f ./flux/vars/global-auto-vars.yaml
	$(KC) get pods -n flux-system
	sleep 10
	$(KC) apply --server-side --kustomize ./flux/config
	sleep 10
	flux reconcile -n flux-system source git flux-system
	flux reconcile -n flux-system kustomization cluster


upgrade:
	${TC} upgrade --wait --nodes 10.9.9.121 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.122 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.123 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.124 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.125 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.130 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.131 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.132 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.133 --image ${TALOS_IMAGE}
	${TC} upgrade --wait --nodes 10.9.9.134 --image ${TALOS_IMAGE}

upgrade-k8s:
	${TC} --nodes 10.9.9.120  upgrade-k8s --to 1.27.4 --dry-run
