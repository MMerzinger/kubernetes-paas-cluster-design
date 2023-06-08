# Traffic Task 2 - Expose the application

After deploying the Ingress Controller and the application, we can go on and expose the app over the Ingress Controller. Therefore, replace `<IP>` inside the `ingress.yaml` file with the value that you received in task-1 (hint: just run `kubectl get svc -n ingress-nginx ingress-nginx-controller -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`).

Now you can expose the application:

```bash
kubectl apply -f ingress.yaml
```

Make sure to access the application via your browser and check:
- HTTP response code is 200
- Content is `Hello from the demo app!`
