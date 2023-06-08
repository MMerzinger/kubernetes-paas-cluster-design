# Monitoring Task 1 - Deploy Prometheus

We will use Prometheus and Grafana for our practice tasks.

Before we step into the installation, inspect the `values-monitoring.yaml`. Make sure to replace `<IP>` with the value of your Ingress Controller IP.

__Hint__: We disabled a few of the components. Just ignore them for now.

Installation of it can be done with one simple `helm` command:

```bash
helm upgrade --install monitoring kube-prometheus-stack \
  --repo https://prometheus-community.github.io/helm-charts \
  --version 46.8.0 \
  --namespace monitoring --create-namespace \
  --values values-monitoring.yaml
```

Now lets inspect what we deployed via:

```bash
kubectl get deploy,ds,sts,ing -n monitoring
NAME                                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monitoring-kube-prometheus-operator   1/1     1            1           19m
deployment.apps/monitoring-kube-state-metrics         1/1     1            1           19m

NAME                                                 DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/monitoring-prometheus-node-exporter   1         1         1       1            1           kubernetes.io/os=linux   19m

NAME                                                                READY   AGE
statefulset.apps/prometheus-monitoring-kube-prometheus-prometheus   1/1     19m

NAME                                                              CLASS   HOSTS                             ADDRESS         PORTS   AGE
ingress.networking.k8s.io/monitoring-kube-prometheus-prometheus   nginx   prometheus-20.166.220.87.nip.io   20.166.220.87   80      16m
```

The output tells us that we just installed:
- The Prometheus operator (managed Prometheus)
- A Prometheus instance (the Prometheus instance itself that observes the exporters)
- Kube state metrics (a tool that fetches information about Kubernetes resources from the api server)
- Node Exporter (a tool that fetches information about the Kubernetes nodes)

Try to access Prometheus via your browser using `prometheus-<IP>.nip.io`.