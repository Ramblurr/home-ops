# Bootstrap

## Flux

### Authenticate Flux

[source](https://github.com/onedr0p/flux-cluster-template/tree/164d81a77c69b0c240af4f3b937778ddc22e5661#-authenticate-flux-over-ssh)

1. Generate new SSH key:
      ```sh
      ssh-keygen -t ecdsa -b 521 -C "github-deploy-key" -f ./kubernetes/bootstrap/github-deploy.key -q -P ""
      ```
2. Paste public key in the deploy keys section of your repository settings
3. Create sops secret in `./kubernetes/bootstrap/github-deploy-key.sops.yaml` with the contents of:
    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
        name: github-deploy-key
        namespace: flux-system
    stringData:
        # 3a. Contents of github-deploy-key
        identity: |
            -----BEGIN OPENSSH PRIVATE KEY-----
                ...
            -----END OPENSSH PRIVATE KEY-----
        # 3b. Output of curl --silent https://api.github.com/meta | jq --raw-output '"github.com "+.ssh_keys[]'
        known_hosts: |
            github.com ssh-ed25519 ...
            github.com ecdsa-sha2-nistp256 ...
            github.com ssh-rsa ...
    ```
4. Encrypt secret:
    ```sh
    sops --encrypt --in-place ./kubernetes/bootstrap/github-deploy-key.sops.yaml
    ```
5. Apply secret to cluster:
    ```sh
    sops --decrypt ./kubernetes/bootstrap/github-deploy-key.sops.yaml | kubectl apply -f -
    ```
6.  Update `./kubernetes/flux/config/cluster.yaml`:
    ```yaml
    apiVersion: source.toolkit.fluxcd.io/v1beta2
    kind: GitRepository
    metadata:
    name: home-kubernetes
    namespace: flux-system
    spec:
    interval: 10m
    # 6a: Change this to your user and repo names
    url: ssh://git@github.com/$user/$repo
    ref:
        branch: main
    secretRef:
        name: github-deploy-key
    ```
7. Commit and push changes
8. Force flux to reconcile your changes
    ```sh
    task cluster:reconcile
    ```
9. Verify git repository is now using SSH:
    ```sh
    task cluster:gitrepositories
    ```
10. Optionally set your repository to Private in your repository settings.


### Install Flux

```sh
kubectl apply --server-side --kustomize ./k8s/cluster-test/bootstrap
```

### Apply Cluster Configuration

```sh
sops -d k8s/cluster-test/bootstrap/age-key.sops.yaml | kubectl apply -f -
sops -d k8s/cluster-test/bootstrap/github-deploy-key.sops.yaml | kubectl apply -f -
sops -d k8s/cluster-test/flux/vars/global-secrets.yaml | kubectl apply -f -
kubectl apply -f k8s/cluster-test/flux/vars/global-vars.yaml
```

Wait until `kubectl get pods -n flux-system` shows all ready.

### Kick off Flux applying this repository

```sh
kubectl apply --server-side --kustomize ./k8s/cluster-test/flux/config
```


### Test cilium connectivity

```
cilium status # all should be green
cilium connectivity test
```

### Test BGP Load Balancer

Don't forget to setup your router to handle BGP for the talos nodes.

Use this manifest to test the BGP load balancer:

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: test-lb
  namespace: cilium-test
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    svc: test-lb
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: cilium-test
spec:
  selector:
    matchLabels:
      svc: test-lb
  template:
    metadata:
      labels:
        svc: test-lb
    spec:
      containers:
      - name: web
        image: nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /
            port: 80
```

```
kubectl apply -f lb-bgp-test.yaml
kubectl -n cilium-test get svc
# wait until external ip is assigned
curl http://<external ip>
kubectl delete -f lb-bgp-test.yaml
```
