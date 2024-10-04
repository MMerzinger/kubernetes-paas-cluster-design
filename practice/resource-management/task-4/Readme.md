# Resource Management Task 4 - Scale compute resources

Lets scale our demo-app-2 a bit and see how Kubernetes behaves. Therefore, please have a look at the file `deployment-demo-app-2.yaml` in this folder and inspect the changes to task-3.

Make sure to re-create the manifest file via `kubectl replace --force -f deployment-demo-app-2.yaml`. 

Check if the deployment can scale to the desired amount of replicas using the previously learned commands. It should be able to scale, but not to the desired amount of replicas.

Please have a look a the solutions branch and the Solution.md file for a full explanation of the behaviour and background infos on requests and limits.