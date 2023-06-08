# Resource Management Task 2 - Solution

The file `deployment-demo-app-1.yaml` misses some required fields.

You can find a complete version in the file `deployment-demo-app-1-solution.yaml`.

To create the deployment inside the cluster, you can do `kubectl apply -f deployment-demo-app-1-solution.yaml`. 

Verify the creation via via `kubectl get deploy -n demo-app-1`. We can see that it has 0 out of 1 ready. Let's have a look at the quota: `kubectl get quota -n demo-app-1`:

```bash
NAME    AGE   REQUEST                      LIMIT
quota   23m   cpu: 0/500m, memory: 0/1Gi
```

Seems there are no resources used. Let us verify if a pod is created, therefore we inspect the ReplicaSet and pods that should be created:

```bash
kubectl get rs,po -n demo-app-1
NAME                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/demo-app-1-c75cbdbc4   1         0         0       24m
```

The ReplicaSet was created through the Deployment, which is right. No pods there, so the ReplicaSet needs to be inspected:

```bash
kubectl describe replicaset.apps/demo-app-1-c75cbdbc4 -n demo-app-1
...
Events:
  Type     Reason        Age                From                   Message
  ----     ------        ----               ----                   -------
  Warning  FailedCreate  25m                replicaset-controller  Error creating: pods "demo-app-1-c75cbdbc4-48m5d" is forbidden: exceeded quota: quota, requested: cpu=1, used: cpu=0, limited: cpu=500m
...
```

Now we can spot under events, that the ReplicaSet cannot create a pod, as this pod requests more cpu, than allowed through the quota.