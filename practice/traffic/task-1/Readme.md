# Traffic Task 1 - Deploy Ingress Controller

We will use NGINX Ingress for our practice tasks. Installation of it can be done with one simple `helm` command:

```bash
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --version 4.7.0 \
  --namespace ingress-nginx --create-namespace \
  --values values-ingress.yaml
```

After running the `helm` command, we need to make sure all pods are up and running:

```bash
kubectl get pods --namespace=ingress-nginx
NAME                                        READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-5964797467-cphxz   1/1     Running   0          24s
```

We need to take a note of the public IP address, that was assigned to our Ingress Controller. You can retrieve it via:

```bash
kubectl get svc -n ingress-nginx ingress-nginx-controller -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"
```

**ATTENTION**: This IP address is required for other tasks during this course. As previously explained, we are going to use `nip.io` for our hostnames.

After deploying the ingress controller, we can deploy a simple application:

```bash
kubectl apply -f app.yaml
```

Verify if the app comes up and is exposed inside the cluster via a service:

```bash
kubectl get deploy,po,svc -n demo-app
```