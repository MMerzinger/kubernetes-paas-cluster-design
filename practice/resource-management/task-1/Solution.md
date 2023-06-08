# Resource Management Task 1 - Solution

Both files `resources-demo-app-1.yaml` and `resources-demo-app-2.yaml` miss the specification of required fields.

You can find a complete version in the files `resources-demo-app-1-solution.yaml` and `resources-demo-app-2-solution.yaml`.

To create them inside the cluster, you can do `kubectl apply -f resources-demo-app-1-solution.yaml -f resources-demo-app-2-solution.yaml`. Verify namespaces via `kubectl get ns` and the quota for each namespace via `kubectl get quota -n demo-app-1` and `kubectl get quota -n demo-app-2` respectively.