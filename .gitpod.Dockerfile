FROM gitpod/workspace-full:latest

RUN sudo apt-get update && \
    sudo apt-get install -y apt-transport-https ca-certificates curl wget apt-transport-https gnupg lsb-release && \
    curl -fsSLo get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    curl -LO https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl && \
    curl -LO "https://dl.k8s.io/v1.25.0/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    chmod 700 get_helm.sh && \
    sudo ./get_helm.sh && \
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list && \
    sudo apt-get update && \
    sudo apt-get install -y trivy && \
    echo 'export KUBECONFIG="/workspace/kubernetes-paas-cluster-design/kube-config.yaml"' >> /home/gitpod/.bashrc && \
    kubectl completion bash >> $HOME/.bashrc