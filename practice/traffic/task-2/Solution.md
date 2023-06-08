# Traffic Task 2 - Solution

After creating the ingress manifest, verify the creation:

```bash
kubectl get ing -n demo-app
NAME                CLASS   HOSTS                  ADDRESS         PORTS   AGE
demo-app            nginx   20.166.220.87.nip.io   20.166.220.87   80      45m
```

The IP neds to be correct and the ingress class.

After that you can access it via your browser, in this example `20.166.220.87.nip.io` or just via:

```bash
curl -v http://20.166.220.87.nip.io/                                         ✔  10448  09:12:09
*   Trying 20.166.220.87:80...
* Connected to 20.166.220.87.nip.io (20.166.220.87) port 80 (#0)
> GET / HTTP/1.1
> Host: 20.166.220.87.nip.io
> User-Agent: curl/7.77.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Thu, 08 Jun 2023 07:12:17 GMT
< Content-Type: text/html; charset=utf-8
< Content-Length: 33
< Connection: keep-alive
< 
* Connection #0 to host 20.166.220.87.nip.io left intact
<h1>Hello from the demo app!</h1>
```