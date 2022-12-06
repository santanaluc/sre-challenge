#!/bin/bash
# Install docker
sudo yum update
sudo yum update  -y
sudo yum install docker -y
sudo service docker stop 
sudo service docker start
sudo chmod 666 /var/run/docker.sock

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check 
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl 

# Install kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Install Git to Deploy
sudo yum install git -y

# Create and initialize cluster
cat <<EOF > /home/ec2-user/create-cluster.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
  extraPortMappings:
  - containerPort: 30950
    hostPort: 80
EOF
sleep 5
sudo /usr/local/bin/kind create cluster --config /home/ec2-user/create-cluster.yaml 2> /home/ec2-user/logs/log.txt
sleep 10
# Add this to resolve the problem of "The connection to the server localhost:8080 was refused - did you specify the right host or port?"
sudo mkdir /home/ec2-user/.kube 2> /home/ec2-user/logs/logmkdir.txt
sudo /usr/local/bin/kind get kubeconfig > /home/ec2-user/.kube/config 2> /home/ec2-user/logs/logkind.txt
