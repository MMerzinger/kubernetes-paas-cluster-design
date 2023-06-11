# Identity Task 2 - Create the app

Now we need the Key Vault URL mentioned earlier. Replace `<YOUR-KEYVAULT-URL>` with the value provided in the email.

Next, replace `<THE-SECRET-NAME-TO-QUERY>` with the value provided in the task description on the slides. Make sure that the value exact the same (case sensitive). 

Create the app via `kubectl apply -f app.yaml`. Verify it via `kubectl get po -n default`. The pod should start.
