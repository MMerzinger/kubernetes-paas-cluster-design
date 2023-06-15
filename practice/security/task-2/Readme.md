# Security Task 2 - Scan manifests

__Hint__: If you do not have trivy installed, use the following command to start a container, that has trivy pre-installed (replace the path to your kubeconfig in the volume mount):

```bash
docker run --rm -it -v /path/to/your/kubeconfig:/root/.kube/config k8spaasclusterdesign.azurecr.io/tools/utilities:0.1.0
```

Create the manifests provided in `manifests.yaml` in your cluster via `kubectl apply -f manifests.yaml`. 

Go on and use trivy to scan the manifests. You can find a few deployments inside the `task-2` namespace.

Identify webservers that have misconfigurations.

You will need the `k8s` subcommand to scan the manifests: `trivy k8s --help`

__Hint__: We are using the [static web server image](https://github.com/static-web-server/static-web-server) as it is very light weight and simple to use. But for this task it is not relevant as we concentrate on the manifests.