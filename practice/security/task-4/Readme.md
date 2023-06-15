# Security Task 4 - Use PSA

Inspect the `restricted.yaml` file. With this spec, we create a namespace called `task-4-res` and warn if any of the PSS restricted policies are violated. Go ahead and create the resources via `kubectl apply -f restricted.yaml`.

Inspect the `deploy.yaml` and create it via 

```bash
kubectl apply -f deploy.yaml
Warning: would violate PodSecurity "restricted:latest": runAsNonRoot != true (container "static-web-server" must not set securityContext.runAsNonRoot=false)
deployment.apps/webserver1 created
```

As you can see, we could create the deployment, although a policy was violated. This is due to our label only specifying to warn: `pod-security.kubernetes.io/warn: restricted`

To go into enforcement mode, we can apply the `enforce` label:

```bash
kubectl label ns task-4-res pod-security.kubernetes.io/enforce=restricted
Warning: existing pods in namespace "task-4-res" violate the new PodSecurity enforce level "restricted:latest"
Warning: webserver1-68fb4d8bc-nnx2p: runAsNonRoot != true
namespace/task-4-res labeled
```

The output clearly shows that we are still violating the policy, but now we run in enforcement mode. Check if the pods are still up and running

```bash
kubectl get po -n task-4-res
NAME                         READY   STATUS    RESTARTS   AGE
webserver1-68fb4d8bc-nnx2p   1/1     Running   0          68s
```

Looks good, but what happens if we delete the pod? (`kubectl delete po -n task-4-res --all`). Delete the pods and check if the deployment re-creates them.

```bash
kubectl get po -n task-4-res
No resources found in task-4-res namespace
```

No pods anymore. As we enforce the policy, the deployment cannot create pods anymore, that violate the policy. Therefore, it is mandatory to fix all violations before enforcing policies!

Change the line 32 to `runAsNonRoot: true`, save and apply the file via `kubectl apply -f deploy.yaml`

Check again if pods start:

```bash
kubectl get po -n task-4-res
NAME                          READY   STATUS    RESTARTS   AGE
webserver1-7d49745d4b-plhbh   1/1     Running   0
```

We are compliant with the policy, pods can start as defined in the deployment manifest.

__Hint__: PSA is very handy if you do not have OPA/Gatekeeper or Kyverno but still want to ensure good security settings on your workload. PSA does not support custom policies that e.g. enforce presence of labels.