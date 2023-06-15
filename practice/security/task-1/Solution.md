# Solution - Security Task 1 - Find images with vulnerabilities

__Hint__: You may receive different results, CVEs are published from time to time. 

Trivy provides a few handy command line flags to make scanning easier. We need to find high/critical vulnerabilities and secrets, hence we can use the following command to scan the images `trivy image --severity HIGH,CRITICAL --scanners vuln,secret <image>`.

Here are the scan results of the first image:

```bash
trivy image --severity HIGH,CRITICAL --scanners vuln,secret k8spaasclusterdesign.azurecr.io/tools/security/ubuntu:bionic
2023-06-12T11:48:29.605+0200    INFO    Vulnerability scanning is enabled
2023-06-12T11:48:29.605+0200    INFO    Secret scanning is enabled
2023-06-12T11:48:29.605+0200    INFO    If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2023-06-12T11:48:29.605+0200    INFO    Please see also https://aquasecurity.github.io/trivy/v0.42/docs/secret/scanning/#recommendation for faster secret detection
2023-06-12T11:48:43.813+0200    INFO    Detected OS: ubuntu
2023-06-12T11:48:43.813+0200    INFO    Detecting Ubuntu vulnerabilities...
2023-06-12T11:48:43.828+0200    INFO    Number of language-specific files: 0
2023-06-12T11:48:43.828+0200    WARN    This OS version is no longer supported by the distribution: ubuntu 18.04
2023-06-12T11:48:43.828+0200    WARN    The vulnerability detection may be insufficient because security updates are not provided

k8spaasclusterdesign.azurecr.io/tools/security/ubuntu:bionic (ubuntu 18.04)

Total: 0 (HIGH: 0, CRITICAL: 0)
```

Looks like the image is good for now.

You can run the same command for the other images. My results as of 12.06.2023 are:
| **Image** | **Vulnerabilities (high/critical)** | **Secrets** |
| --- | --- | --- |
| ubuntu:bionic | 0 | 0 |
| dotnet/runtime:7.0-alpine | 2 high | 0 |
| base:1.0.5 | 0 | 0 |
| secrets:2.5.0 | 0 | 1 private key |
