# Solution - Identity Task 1 - Setup a service account

You can find the solution in `sa-solution.yaml` but still, you have to replace the clientId.

To enable Workload Identity, you have to set the label `azure.workload.identity/use: "true"`.

Afterwards create the service account via `kubectl apply -f sa-solution.yaml`. Verify it via `kubectl get sa azure-workload-identity -o yaml`.
