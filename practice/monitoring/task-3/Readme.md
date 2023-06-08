# Monitoring Task 3 - Deploy demo app with exporter

Now that we have deployed and discovered out monitoring stack, we can go on and deploy an application that exposes custom metrics.

Inspect the provided manifests in `app.yaml`. Make sure to understand where the application listens for requests and in which namespace it is deployed.

Next, deploy the application via `kubectl apply -f app.yaml`.

Forward the http port of the application to your localhost and call the app:

```bash
kubectl port-forward -n demo-app svc/demo-app 8080:8080 &
curl localhost:8080
<h1>Hello from the demo app!</h1>
```

Now we need to check if metrics are exposed. Call the standard `/metrics` endpoint:

```bash
curl localhost:8080/metrics
...
# HELP flask_http_request_duration_seconds Flask HTTP request duration in seconds
# TYPE flask_http_request_duration_seconds histogram
# HELP flask_http_request_total Total number of HTTP requests
# TYPE flask_http_request_total counter
# HELP flask_http_request_exceptions_total Total number of HTTP requests which resulted in an exception
# TYPE flask_http_request_exceptions_total counter
# HELP app_info Application info
# TYPE app_info gauge
app_info{version="0.2.0"} 1.0
# HELP http_requests_webroot_total Invocations of webroot
# TYPE http_requests_webroot_total counter
http_requests_webroot_total 0.0
# HELP http_requests_webroot_created Invocations of webroot
# TYPE http_requests_webroot_created gauge
http_requests_webroot_created 1.6862159357492118e+09
```

Quite some metrics. Call a few times the app via `curl http://localhost:8080`.

After that call the metrics endpoint again. Now you should see an increase of the `http_requests_webroot_total` metric.

```bash
# HELP flask_http_request_exceptions_total Total number of HTTP requests which resulted in an exception
# TYPE flask_http_request_exceptions_total counter
# HELP app_info Application info
# TYPE app_info gauge
app_info{version="0.2.0"} 1.0
# HELP http_requests_webroot_total Invocations of webroot
# TYPE http_requests_webroot_total counter
http_requests_webroot_total 4.0
# HELP http_requests_webroot_created Invocations of webroot
# TYPE http_requests_webroot_created gauge
http_requests_webroot_created 1.6862159357492118e+09
```

The application is now ready for Prometheus.
