# Security Task 3 - Generate certificate for Ingress Controller

For certificate management we need cert-manager. Cert-manager can simply be installed via kubectl. Run the following command to install cert-manager in your cluster:

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
```

Check if cert-manager is up and running:

```bash
kubectl get po -n cert-manager
```

Now we can deploy our application. Inspect the provided manifests `app.yaml` and create them in the cluster via `kubectl apply -f app.yaml`. This creates a namespace, deployment and a service. Verify that the app is up and running. As of now, it is just available in the cluster and not exposed to the internet.

As we are using a self-signed certificate, we can create a new issuer in cert-manager. Inspect the file `certs.yaml`. Cert-manager supports namespaced (Issuer) and cluster wide (ClusterIssuer) resources. Both are used to describe a place that can issue certificates, e.g. self-signed or Let\`s Encrypt. 
In addition to the issuer we need a certificate. This is the second resource in the `certs.yaml`. The certificate specifies the common name that we want to have a certificate for, where to store the certificate (a Kubernetes secret) and which issuer to use. Make sure to replace `<IP>` with the IP of your ingress controller and then apply the `certs.yaml` via `kubectl apply -f certs.yaml`.

Verify that cert-manager issued a certificate via 

```bash
kubectl get certificate -n task-3
NAME              READY   SECRET           AGE
app-certificate   True    app-tls-secret   7s

kubectl describe certificate -n task-3
Name:         app-certificate
Namespace:    task-3
Labels:       <none>
Annotations:  <none>
API Version:  cert-manager.io/v1
Kind:         Certificate
Metadata:
  Creation Timestamp:  2023-06-15T06:39:40Z
  Generation:          1
  Resource Version:    16984
  UID:                 812b1ca8-34b5-4d27-b9b6-8ff20221b7a8
Spec:
  Common Name:  app-20.105.102.221.nip.io
  Is CA:        true
  Issuer Ref:
    Group:  cert-manager.io
    Kind:   ClusterIssuer
    Name:   selfsigned-cluster-issuer
  Private Key:
    Algorithm:  ECDSA
    Size:       256
  Secret Name:  app-tls-secret
Status:
  Conditions:
    Last Transition Time:  2023-06-15T06:39:40Z
    Message:               Certificate is up to date and has not expired
    Observed Generation:   1
    Reason:                Ready
    Status:                True
    Type:                  Ready
  Not After:               2023-09-13T06:39:40Z
  Not Before:              2023-06-15T06:39:40Z
  Renewal Time:            2023-08-14T06:39:40Z
  Revision:                1
Events:
  Type    Reason     Age    From                                       Message
  ----    ------     ----   ----                                       -------
  Normal  Issuing    2m57s  cert-manager-certificates-trigger          Issuing certificate as Secret does not exist
  Normal  Generated  2m57s  cert-manager-certificates-key-manager      Stored new private key in temporary Secret resource "app-certificate-hvs2p"
  Normal  Requested  2m57s  cert-manager-certificates-request-manager  Created new CertificateRequest resource "app-certificate-xrpmj"
  Normal  Issuing    2m57s  cert-manager-certificates-issuing          The certificate has been successfully issued
```

As you can see in the events of the certificate resource: Cert-manager creates a certificate request in the background and tracks the issuing of the certificate. You can have a look on the final certificate, which is stored in the secret `app-tls-secret`.

At this point in time we have an internal app up and running and a certificate. Time to expose it via the Ingress Controller.

Inspect the `ingress.yaml` and replace `<IP>` with the value of your Ingress Controller IP. As you can see in line 11 to 14, we are referencing the seccret `app-tls-secret`, which will be used to terminate TLS connections. Go on and apply the resource via `kubectl apply -f ingress.yaml`.

Verify that you can connect to your app with HTTPS and the connection is secured with a self-signed certificate:

```bash
curl -v -k https://app-20.105.102.221.nip.io
* Rebuilt URL to: https://app-20.105.102.221.nip.io/
*   Trying 20.105.102.221...
* TCP_NODELAY set
* Connected to app-20.105.102.221.nip.io (20.105.102.221) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Unknown (8):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Client hello (1):
* TLSv1.3 (OUT), TLS Unknown, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=app-20.105.102.221.nip.io
*  start date: Jun 15 06:39:40 2023 GMT
*  expire date: Sep 13 06:39:40 2023 GMT
*  issuer: CN=app-20.105.102.221.nip.io
*  SSL certificate verify result: self signed certificate (18), continuing anyway.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* Using Stream ID: 1 (easy handle 0x555658630620)
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
> GET / HTTP/2
> Host: app-20.105.102.221.nip.io
> User-Agent: curl/7.58.0
> Accept: */*
> 
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* Connection state changed (MAX_CONCURRENT_STREAMS updated)!
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
< HTTP/2 200 
< date: Thu, 15 Jun 2023 06:54:51 GMT
< content-type: text/html; charset=utf-8
< content-length: 33
< strict-transport-security: max-age=15724800; includeSubDomains
< 
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* Connection #0 to host app-20.105.102.221.nip.io left intact
```

As you can see our CN is app-20.105.102.221.nip.io, just as specified in the certificate resource. That is it :)

You may want to enforce clients to use HTTPS and send redirects from HTTP to HTTPS. Have a look at this annotation of NGNIX, that achieves this goal: https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#server-side-https-enforcement-through-redirect

## Troubleshooting

If you access your app with HTTPS and you have a CN called Kubernetes Ingress Controller Fake Certificate, then you are using the certificate created by NGINX and not the self-signed from this task:

```bash
curl -v -k https://app-20.105.102.221.nip.io
* Rebuilt URL to: https://app-20.105.102.221.nip.io/
*   Trying 20.105.102.221...
* TCP_NODELAY set
* Connected to app-20.105.102.221.nip.io (20.105.102.221) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Unknown (8):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Client hello (1):
* TLSv1.3 (OUT), TLS Unknown, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: O=Acme Co; CN=Kubernetes Ingress Controller Fake Certificate
*  start date: Jun 15 06:32:07 2023 GMT
*  expire date: Jun 14 06:32:07 2024 GMT
*  issuer: O=Acme Co; CN=Kubernetes Ingress Controller Fake Certificate
*  SSL certificate verify result: unable to get local issuer certificate (20), continuing anyway.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* Using Stream ID: 1 (easy handle 0x55b9dd9ba620)
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
> GET / HTTP/2
> Host: app-20.105.102.221.nip.io
> User-Agent: curl/7.58.0
> Accept: */*
> 
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* Connection state changed (MAX_CONCURRENT_STREAMS updated)!
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
< HTTP/2 200 
< date: Thu, 15 Jun 2023 06:47:12 GMT
< content-type: text/html; charset=utf-8
< content-length: 33
< strict-transport-security: max-age=15724800; includeSubDomains
< 
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* Connection #0 to host app-20.105.102.221.nip.io left intact
```