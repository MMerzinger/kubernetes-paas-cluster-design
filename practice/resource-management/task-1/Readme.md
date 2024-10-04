# Resource Management Task 1 - Deploy quota and namespace resources

This task combines a quick refresh of your `kubectl` know-how and creation of the quota resource. Please fill out the manifests (missing parts have a `?`) and create the resources in your Kubernetes cluster:

```bash
# Manifests is complete, then create it via
kubectl apply -f <the-file-you-want-to-apply>
```

Check if everything is available:

```bash
kubectl get ns
# You need to have the demo-app-1 and demo-app-2 namespaces
# Check the available quotas
kubectl get quota -n <namespace>
# You need to have one quota resource per demo namespace. As of now we have it created but no quota used.
```
