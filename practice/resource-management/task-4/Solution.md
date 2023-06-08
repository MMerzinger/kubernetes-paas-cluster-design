# Resource Management Task 4 - Solution

You can simply __re-create__ the deployment via `kubectl replace --force -f deployment-demo-app-2.yaml`.

As indicated by the name and content of the file, we need to check `demo-app-2`: 

```bash
kubectl get deploy,po,quota -n demo-app-2
NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/demo-app-2   9/12    10           9           4m

NAME                             READY   STATUS    RESTARTS   AGE
pod/demo-app-2-c67b4c5cd-2kcqr   1/1     Running   0          3m58s
pod/demo-app-2-c67b4c5cd-2mk5t   1/1     Running   0          4m
pod/demo-app-2-c67b4c5cd-4zvcr   1/1     Running   0          4m
pod/demo-app-2-c67b4c5cd-5wcjk   1/1     Running   0          3m58s
pod/demo-app-2-c67b4c5cd-k9ffk   1/1     Running   0          3m57s
pod/demo-app-2-c67b4c5cd-n5xc6   0/1     Pending   0          3m57s
pod/demo-app-2-c67b4c5cd-nx8pj   1/1     Running   0          3m57s
pod/demo-app-2-c67b4c5cd-qxxdn   1/1     Running   0          3m57s
pod/demo-app-2-c67b4c5cd-v7ckd   1/1     Running   0          3m58s
pod/demo-app-2-c67b4c5cd-x4n4v   1/1     Running   0          3m57s

NAME                  AGE   REQUEST                                          LIMIT
resourcequota/quota   51m   requests.cpu: 1/1, requests.memory: 1280Mi/2Gi   
```

We can see that our Deployment scales to 9/12 of the desired replicas. A look at the quota shows that we have reached the upper limit.

Another detail that we can take from the `deployment-demo-app-2.yaml` is that the pod only specifies `resources.limits` and not `resources.requests` as before. Although we only specified limits, all pods are created with both requests and limits. This is intended behavior from Kubernetes. More details can be found [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/).

__NOTE__: Reaching the quota upper limit is bad. Especially when you still need more resources. For example, rolling updates will not succeed, as the deployment waits to reach its desired amout of replicas.

