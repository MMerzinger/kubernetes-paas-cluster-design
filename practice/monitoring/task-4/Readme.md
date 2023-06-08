# Monitoring Task 4 - Scrape the application from Prometheus

As we are using the Prometheus Operator, there is a handy CRD (Custom Resource Defintion), which allows us to specify targets, that will be automatically be scraped. This CRD is called `ServiceMonitor`.

Please inspect the `app.yaml`. Fill out the `?` and apply it into the cluster via `kubectl apply -f app.yaml`.

Verify the creation of the ServiceMonitor via:

```bash
kubectl get servicemonitor -n demo-app
```

To verify if our application is monitored properly, checkout the Prometheus UI under `prometheus-<IP>.nip.io/service-discovery?search=`. You should find an entry called `serviceMonitor/demo-app/demo-app` (it may take a minute to appear). If that is the case, switch to the `Graph` tab and query for `http_requests_webroot_total` and you should see the value of the metric. Play around, call the application a few more times and observe how the value of the metric changes.

There are a few more options to specify targets, that shall be monitored by the Prometheus Operator. Have a look at the [docs](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md) for more info.