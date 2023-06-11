# Identity Task 3 - Easter egg

Inspect the output from the pod created in task-2 (`kubectl logs -n default app`).

The pod should:
- Authenticate to the provided KeyVault (URL) with the client ID of the service account
- Fetch a secret called `the-alleged-api-password`
- Print the content of the secret

Can you answer the question provided in the content of the secret? If yes, try to find a secret called like the answer...