# Resource Management Task 3 - Solution

You can simply create the deployment via `kubectl apply -f deployment-demo-app-2.yaml`.

As indicated by the name and content of the file, we need to check `demo-app-2`: 

```bash
kubectl get deploy,po,quota -n demo-app-2
NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/demo-app-2   3/3     3            3           2m21s

NAME                              READY   STATUS    RESTARTS   AGE
pod/demo-app-2-7789bb87d9-7dttg   1/1     Running   0          2m21s
pod/demo-app-2-7789bb87d9-94qvh   1/1     Running   0          2m21s
pod/demo-app-2-7789bb87d9-bwsxx   1/1     Running   0          2m21s

NAME                  AGE   REQUEST                          LIMIT
resourcequota/quota   34m   cpu: 750m/1, memory: 384Mi/2Gi
```

Everything comes up, we have 3 of 3 ready replicas. There are still some resources left to be used, hence we are below the defined quota.