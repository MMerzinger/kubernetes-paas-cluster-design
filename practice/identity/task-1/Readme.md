# Identity Task 1 - Setup a service account

Check the email you received earlier with the K8s credentials. In addition to that the email contains a Key Vault URL and a clientId.

Use the clientId to fill out the placeholder in `sa.yaml`.

Make sure to enable Workload Identity for this service account by setting the correct value of the second placeholder.

Afterwards create the service account via `kubectl apply -f sa.yaml`.