# Traffic Task 3 - Solution

After creating the ingress manifest, verify the creation:

```bash
kubectl get ing -n demo-app
NAME                CLASS   HOSTS                  ADDRESS         PORTS   AGE
demo-app            nginx   20.166.220.87.nip.io   20.166.220.87   80      51m
demo-app-advanced   nginx   20.166.220.87.nip.io   20.166.220.87   80      6m55s
```

Now there are two ingress manifests, specifying the same host. This works as long as there is no overlap in the paths that they specify.

When inspecting the advanced manifest a bit, we can see the following sections:

```yaml
metadata:
  annotations:
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /try-to-find-me/here-i-am
...
      paths:
      - path: /(.*)/what-path-it-is
```

This is the interesting part. The annotations specify that nginx should use regex to parse the incoming request paths. Hence, we can specify `path: /(.*)/what-path-it-is`, which translates into the path has to start with a `/`, then any character, and then it has to end with `/what-path-it-is`. The second annotation `nginx.ingress.kubernetes.io/rewrite-target: /try-to-find-me/here-i-am` then specifies the target path, that has to be used on the backend. In essence all requests that match the inbound path `/any-character/what-path-it-is` will end up on the backend unter path `/try-to-find-me/here-i-am`.

Try it out:

```bash
curl -v http://20.166.220.87.nip.io/i-dont-know/what-path-it-is
*   Trying 20.166.220.87:80...
* Connected to 20.166.220.87.nip.io (20.166.220.87) port 80 (#0)
> GET /i-dont-know/what-path-it-is HTTP/1.1
> Host: 20.166.220.87.nip.io
> User-Agent: curl/7.77.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Thu, 08 Jun 2023 07:26:22 GMT
< Content-Type: text/html; charset=utf-8
< Content-Length: 41
< Connection: keep-alive
< 
* Connection #0 to host 20.166.220.87.nip.io left intact
<h1>You found the hidden endpoint :)</h1>%
```

__NOTE__: Make sure to use your public IP.