.ONESHELL:
.SHELLFLAGS += -e -o pipefail

export ROOT := $(realpath /var/home/ramblurr/src/home-ops/ansible/..)
export CLUSTER := "cluster-test"
export TALOS_DIR := $(realpath /var/home/ramblurr/src/home-ops/ansible/../talos/cluster-test)
export K8S_DIR := $(realpath /var/home/ramblurr/src/home-ops/ansible/../k8s/cluster-test)
export TALOSCONFIG := ${TALOS_DIR}/clusterconfig/talosconfig
export KUBECONFIG := ${TALOS_DIR}/kubeconfig

TC := talosctl --talosconfig ${TALOSCONFIG}
KC := kubectl
CP_IPS = 10.9.9.101 10.9.9.102 10.9.9.103
CP_ARGS = $(addprefix -n ,$(CP_IPS))
CP_ENDPOINT = 10.9.9.101
ARGS ?=

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


	${TC} apply-config --insecure --nodes 10.9.9.101 --file clusterconfig/cluster-test-cp0.cluster-test.mgmt.socozy.casa.yaml
	${TC} apply-config --insecure --nodes 10.9.9.102 --file clusterconfig/cluster-test-cp1.cluster-test.mgmt.socozy.casa.yaml
	${TC} apply-config --insecure --nodes 10.9.9.103 --file clusterconfig/cluster-test-cp2.cluster-test.mgmt.socozy.casa.yaml
bootstrap:
	${TC} bootstrap --nodes 10.9.9.101

kubeconf:
	${TC} kubeconfig --nodes 10.9.9.101 -f .

reboot:

	${TC} reboot --nodes 10.9.9.101 --wait  $(ARGS)
	${TC} reboot --nodes 10.9.9.102 --wait  $(ARGS)
	${TC} reboot --nodes 10.9.9.103 --wait  $(ARGS)
reboot-now:

	${TC} reboot --nodes 10.9.9.101 $(ARGS)
	${TC} reboot --nodes 10.9.9.102 $(ARGS)
	${TC} reboot --nodes 10.9.9.103 $(ARGS)
reapply:

	${TC} apply-config --nodes 10.9.9.101 --file clusterconfig/cluster-test-cp0.cluster-test.mgmt.socozy.casa.yaml $(ARGS)
	${TC} apply-config --nodes 10.9.9.102 --file clusterconfig/cluster-test-cp1.cluster-test.mgmt.socozy.casa.yaml $(ARGS)
	${TC} apply-config --nodes 10.9.9.103 --file clusterconfig/cluster-test-cp2.cluster-test.mgmt.socozy.casa.yaml $(ARGS)
apply-extras:
	${KC} kustomize --enable-helm ./cni | kubectl apply -f -
	${KC} kustomize --enable-helm ./kubelet-csr-approver | kubectl apply -f -

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
