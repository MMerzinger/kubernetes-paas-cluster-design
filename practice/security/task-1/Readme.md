# Security Task 1 - Find images with vulnerabilities

__Hint__: If you do not have trivy installed, use the following command to start a container, that has trivy pre-installed:

```bash
docker run --rm -it k8spaasclusterdesign.azurecr.io/tools/utilities:0.1.0
```

Go through the following images and scan them with trivy. To scan an image you can use the following command: `trivy image <name-of-image>`

Try to find the image(s) that has NO high/critical vulnerabilities and NO secrets in the image:
- k8spaasclusterdesign.azurecr.io/tools/security/ubuntu:bionic
  - (based on docker.io/library/ubuntu:bionic)
- k8spaasclusterdesign.azurecr.io/tools/security/dotnet/runtime:7.0-alpine
  - (based on mcr.microsoft.com/dotnet/runtime:7.0-alpine)
- k8spaasclusterdesign.azurecr.io/tools/security/base:1.0.5
- k8spaasclusterdesign.azurecr.io/tools/security/secrets:2.5.0

Documentation of trivy is available [here](https://aquasecurity.github.io/trivy/v0.42/docs/).

Test trivy out, you can change for example the output format, which helps to include trivy inside your CI/CD pipelines and display the result inside your Tooling.