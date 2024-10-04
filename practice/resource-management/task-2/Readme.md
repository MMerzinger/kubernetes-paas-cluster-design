# Resource Management Task 2 - Deploy compute resources

After creating namespaces and quotas, we want to consume the quotas. Please have a look at the provided manifest and fill out the missing parts marked with a `?`. Here, we use the task again to do a bit of a refresher on your Kubernetes manifest know-how. If the manifest is complete, create the deployment:

```bash
# Manifests is complete, then create it via
kubectl apply -f <the-file-you-want-to-apply>
```

Check if the deployment was created:

```bash
kubectl get deploy -n <namespace>
# You need to have one deployment called demo-app-1
```

Investigate why we are missing a few pods. Use the following commands as a starting point:


```bash
kubectl get quota -n <namespace>
kubectl describe replicaset -n <namespace> <replicaset-name>

```

Hint: There is an issue with the quotas. 