# Accompanying exercises for the Kubernetes PaaS Cluster Design course

[![Gitpod open-workspace](https://img.shields.io/badge/Gitpod-ready--to--code-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/MMerzinger/kubernetes-paas-cluster-design)

This repository contains the accompanying practice tasks for the Kubernetes PaaS Cluster Design course. 

To follow along the practice tasks, you have to options:

1. Install the following tools locally: kubectl, helm and a container engine like Docker
2. Use Gitpod with all tools pre-installed. Register and start [Gitpod](https://gitpod.io/#https://github.com/MMerzinger/kubernetes-paas-cluster-design)

Please make sure to initialize your setup as explained in the initial mail.

## A note about PowerShell

Commands found in this repo were tested with PowerShell Core. You may have PowerShell Version 5 installed locally, which you can check with `$PSVersionTable`. In this case some commands, especially `curl`/`Invoke-WebRequest` behave quite different than `bash` or PowerShell Core. You may need to use wrapper such as `(Invoke-WebRequest <URL>).Content`.

## Additional tooling

In some practice tasks you need more tools. Use the following command to start a container with all required tools (it also includes kubectl and helm):

```bash
docker run --rm -it -v /path/to/the/kubeconfig:/root/.kube/config -v /path/to/the/code:/code k8spaasclusterdesign.azurecr.io/tools/utilities:0.1.0
```

It will open a shell in the container, and then you can use kubectl, helm and trivy.

## Structure

The following output of `tree -L 2` shows the folder structure of this repo:

```bash
.
├── LICENSE
├── Readme.md
├── practice -> Practice tasks for each section
│   ├── identity
│   ├── monitoring
│   ├── resource-management
│   ├── security
│   └── traffic
└── tools -> Used to build example images
    ├── demo-app
    ├── password
    ├── scratch
    └── utilities-image
```

## License

MIT: https://marcm.mit-license.org