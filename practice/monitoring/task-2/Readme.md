# Monitoring Task 2 - Deploy Grafana

After we installed Prometheus, we continue with Grafana. Luckily the Helm chart that we use is very sophisticated.

Inspect the `values-monitoring.yaml` and enable the creation of Grafana. Make sure to replace `<IP>` with the value of your Ingress Controller IP.

Upgrade of it can be done with one simple `helm` command:

```bash
helm upgrade --install monitoring kube-prometheus-stack \
  --repo https://prometheus-community.github.io/helm-charts \
  --version 46.8.0 \
  --namespace monitoring --create-namespace \
  --values values-monitoring.yaml
```

Again, as with Prometheus, lets see what was deployed:

```bash
kubectl get deploy,ds,sts,ing -n monitoring
NAME                                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monitoring-grafana                    1/1     1            1           58s
deployment.apps/monitoring-kube-prometheus-operator   1/1     1            1           27m
deployment.apps/monitoring-kube-state-metrics         1/1     1            1           27m

NAME                                                 DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/monitoring-prometheus-node-exporter   1         1         1       1            1           kubernetes.io/os=linux   27m

NAME                                                                READY   AGE
statefulset.apps/prometheus-monitoring-kube-prometheus-prometheus   1/1     27m

NAME                                                              CLASS   HOSTS                             ADDRESS         PORTS   AGE
ingress.networking.k8s.io/monitoring-grafana                      nginx   grafana-20.166.220.87.nip.io      20.166.220.87   80      58s
ingress.networking.k8s.io/monitoring-kube-prometheus-prometheus   nginx   prometheus-20.166.220.87.nip.io   20.166.220.87   80      23m
```

Now Grafana was installed, in addition to the previously installed tools. As defined in the `values-monitoring.yaml`, you should be able to access Grafana under `grafana-<IP>.nip.io`.

By default you need a password. It is located in a secret inside the `monitoring` namespace. You can fetch the username and password with the following commands:

```bash
kubectl get secret -n monitoring monitoring-grafana -o=jsonpath='{.data.admin-password}' | base64 -d
prom-operator
kubectl get secret -n monitoring monitoring-grafana -o=jsonpath='{.data.admin-user}' | base64 -d
admin
```

Now you can go on and login to Grafana. Checkout the `Kubernetes Cluster Dasboard` and see how your cluster is utilized.
