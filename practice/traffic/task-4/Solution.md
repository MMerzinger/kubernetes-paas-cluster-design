# Traffic Task 4 - Solution

You can find the required solution in `values-ingress.yaml`. As you can see we just need to enable the default backend.

Apply it via:

```bash
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --version 4.7.0 \
  --namespace ingress-nginx --create-namespace \
  --values values-ingress-solution.yaml
```


The default backend provided by the Helm chart is quite simple, but a good starting point to create your own image that serves the default backend.

