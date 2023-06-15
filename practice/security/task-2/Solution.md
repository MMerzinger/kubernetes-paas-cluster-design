# Solution - Security Task 2 - Scan manifests

To scan manifests in a cluster with trivy we need the command `trivy k8s --quiet --namespace=<namespace> --report=summary deploy` to get a overview.

```bash
trivy k8s --quiet --namespace=task-2 --report=summary deploy

Summary Report for mmek8spaas
Workload Assessment
┌───────────┬───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
│ Namespace │       Resource        │  Vulnerabilities  │ Misconfigurations │      Secrets      │
│           │                       ├───┬───┬───┬───┬───┼───┬───┬───┬───┬───┼───┬───┬───┬───┬───┤
│           │                       │ C │ H │ M │ L │ U │ C │ H │ M │ L │ U │ C │ H │ M │ L │ U │
├───────────┼───────────────────────┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
│ task-2    │ Deployment/webserver3 │   │   │   │   │   │   │   │   │ 4 │   │   │   │   │   │   │
│ task-2    │ Deployment/webserver2 │   │   │   │   │   │   │   │ 1 │   │   │   │   │   │   │   │
└───────────┴───────────────────────┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
Severities: C=CRITICAL H=HIGH M=MEDIUM L=LOW U=UNKNOWN
```

As you can see, webserver2 and webserver3 have misconfigurations and webserver1 is ok. To analyse those miscocnfigurations we need to change the output report to `all` of the trivy command: 

```bash
trivy k8s --quiet --namespace=task-2 --report=all deploy


task-2-Deployment-webserver3-1897244881.yaml (kubernetes)

Tests: 141 (SUCCESSES: 137, FAILURES: 4, EXCEPTIONS: 0)
Failures: 4 (UNKNOWN: 0, LOW: 4, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

LOW: Container 'static-web-server' of Deployment 'webserver3' should set 'resources.limits.cpu'
═════════════════════════════════════════════════════════════════════════════════════════
Enforcing CPU limits prevents DoS via resource exhaustion.

See https://avd.aquasec.com/misconfig/ksv011
─────────────────────────────────────────────────────────────────────────────────────────
 task-2-Deployment-webserver3-1897244881.yaml:133-152
─────────────────────────────────────────────────────────────────────────────────────────
 133 ┌                 - env:
 134 │                     - name: SERVER_PORT
 135 │                       value: "8080"
 136 │                   image: joseluisq/static-web-server:2.18
 137 │                   imagePullPolicy: IfNotPresent
 138 │                   name: static-web-server
 139 │                   resources: {}
 140 │                   securityContext:
 141 └                     allowPrivilegeEscalation: false
 ...   
─────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'static-web-server' of Deployment 'webserver3' should set 'resources.requests.cpu'
═════════════════════════════════════════════════════════════════════════════════════════
When containers have resource requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention.

See https://avd.aquasec.com/misconfig/ksv015
─────────────────────────────────────────────────────────────────────────────────────────
 task-2-Deployment-webserver3-1897244881.yaml:133-152
─────────────────────────────────────────────────────────────────────────────────────────
 133 ┌                 - env:
 134 │                     - name: SERVER_PORT
 135 │                       value: "8080"
 136 │                   image: joseluisq/static-web-server:2.18
 137 │                   imagePullPolicy: IfNotPresent
 138 │                   name: static-web-server
 139 │                   resources: {}
 140 │                   securityContext:
 141 └                     allowPrivilegeEscalation: false
 ...   
─────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'static-web-server' of Deployment 'webserver3' should set 'resources.requests.memory'
═════════════════════════════════════════════════════════════════════════════════════════
When containers have memory requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention.

See https://avd.aquasec.com/misconfig/ksv016
─────────────────────────────────────────────────────────────────────────────────────────
 task-2-Deployment-webserver3-1897244881.yaml:133-152
─────────────────────────────────────────────────────────────────────────────────────────
 133 ┌                 - env:
 134 │                     - name: SERVER_PORT
 135 │                       value: "8080"
 136 │                   image: joseluisq/static-web-server:2.18
 137 │                   imagePullPolicy: IfNotPresent
 138 │                   name: static-web-server
 139 │                   resources: {}
 140 │                   securityContext:
 141 └                     allowPrivilegeEscalation: false
 ...   
─────────────────────────────────────────────────────────────────────────────────────────


LOW: Container 'static-web-server' of Deployment 'webserver3' should set 'resources.limits.memory'
═════════════════════════════════════════════════════════════════════════════════════════
Enforcing memory limits prevents DoS via resource exhaustion.

See https://avd.aquasec.com/misconfig/ksv018
─────────────────────────────────────────────────────────────────────────────────────────
 task-2-Deployment-webserver3-1897244881.yaml:133-152
─────────────────────────────────────────────────────────────────────────────────────────
 133 ┌                 - env:
 134 │                     - name: SERVER_PORT
 135 │                       value: "8080"
 136 │                   image: joseluisq/static-web-server:2.18
 137 │                   imagePullPolicy: IfNotPresent
 138 │                   name: static-web-server
 139 │                   resources: {}
 140 │                   securityContext:
 141 └                     allowPrivilegeEscalation: false
 ...   
─────────────────────────────────────────────────────────────────────────────────────────



task-2-Deployment-webserver2-2753053197.yaml (kubernetes)

Tests: 141 (SUCCESSES: 140, FAILURES: 1, EXCEPTIONS: 0)
Failures: 1 (UNKNOWN: 0, LOW: 0, MEDIUM: 1, HIGH: 0, CRITICAL: 0)

MEDIUM: Container 'static-web-server' of Deployment 'webserver2' should specify an image tag
═════════════════════════════════════════════════════════════════════════════════════════
It is best to avoid using the ':latest' image tag when deploying containers in production. Doing so makes it hard to track which version of the image is running, and hard to roll back the version.

See https://avd.aquasec.com/misconfig/ksv013
─────────────────────────────────────────────────────────────────────────────────────────
 task-2-Deployment-webserver2-2753053197.yaml:142-167
─────────────────────────────────────────────────────────────────────────────────────────
 142 ┌                 - env:
 143 │                     - name: SERVER_PORT
 144 │                       value: "8080"
 145 │                   image: joseluisq/static-web-server
 146 │                   imagePullPolicy: Always
 147 │                   name: static-web-server
 148 │                   resources:
 149 │                     limits:
 150 └                         cpu: 100m
 ...   
─────────────────────────────────────────────────────────────────────────────────────────
``` 

As you can see, trivy provides a detailed description of the findings and how to mitigate them. 

Feel free to fix some of the misconfigurations, you can take webserver1 as an example - it is properly configured.

Scanning manifests this way is quite easy and fast to to. Especially if you have to work on a cluster that you do not manage, but there is workload pre-installed and you need to know the current state of configuration (issues).