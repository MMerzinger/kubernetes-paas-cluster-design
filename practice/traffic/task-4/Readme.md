# Traffic Task 4 - Default backend

It depends on the Ingress Controller implementation, but usually a default backend is either included or can be configured. In our case we use nginx, hence we can have a look at the values of the Helm chart to see if we can specify a default backend.

But first lets see what happens if we call an endpoint that should definitely not exist (make sure to replace the IP with your own):

```bash
curl -v http://non-existing-20.166.220.87.nip.io/
*   Trying 20.166.220.87:80...
* Connected to non-existing-20.166.220.87.nip.io (20.166.220.87) port 80 (#0)
> GET / HTTP/1.1
> Host: non-existing-20.166.220.87.nip.io
> User-Agent: curl/7.77.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 404 Not Found
< Date: Thu, 08 Jun 2023 07:35:37 GMT
< Content-Type: text/html
< Content-Length: 146
< Connection: keep-alive
< 
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
* Connection #0 to host non-existing-20.166.220.87.nip.io left intact
```

We can see that nginx responds with a 404 and a simple HTML site.

Go on and enable the backend, have a look at `values-ingress.yaml` and the [nginx docs](https://github.com/kubernetes/ingress-nginx/tree/helm-chart-4.7.0/charts/ingress-nginx). After changing the `values-ingress.yaml` you need to apply the changes into the cluster using helm:

```bash
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --version 4.7.0 \
  --namespace ingress-nginx --create-namespace \
  --values values-ingress.yaml
```

After enabling the default backend you should receive the following response:

```bash
curl -v http://non-existing-20.166.220.87.nip.io/
*   Trying 20.166.220.87:80...
* Connected to non-existing-20.166.220.87.nip.io (20.166.220.87) port 80 (#0)
> GET / HTTP/1.1
> Host: non-existing-20.166.220.87.nip.io
> User-Agent: curl/7.77.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 404 Not Found
< Date: Thu, 08 Jun 2023 07:33:00 GMT
< Content-Type: text/plain; charset=utf-8
< Content-Length: 21
< Connection: keep-alive
< 
* Connection #0 to host non-existing-20.166.220.87.nip.io left intact
default backend - 404%
```

The difference is (unfortunately) minimal, but now we do not receive a 404 HTML page, but just a generic text without specifying the webserver.

A default backend allow you to:
- Standardize 404s over the whole cluster
- Use a container to respond to common error codes
- Override the default 404 pages provided by nginx


## Finally

Please keep your ingress controller. We need it later again.