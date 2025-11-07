# kubernates
#!/bin/bash
# Kubernetes installation script for Ubuntu (Master and Worker)
# Author: Prasanth Reddy

set -e

echo "-----------------------------"
echo "Updating system and installing dependencies..."
echo "-----------------------------"
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo "-----------------------------"
echo "Disabling swap..."
echo "-----------------------------"
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "-----------------------------"
echo "Loading necessary kernel modules..."
echo "-----------------------------"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

echo "-----------------------------"
echo "Setting sysctl params for Kubernetes..."
echo "-----------------------------"
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

echo "-----------------------------"
echo "Installing containerd runtime..."
echo "-----------------------------"
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null

# Set SystemdCgroup = true (required for Kubernetes)
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd

echo "-----------------------------"
echo "Adding Kubernetes apt repository..."
echo "-----------------------------"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | \
  sudo tee /etc/apt/sources.list.d/kubernet
  es.list

sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "-----------------------------"
echo "Kubernetes installation completed successfully!"
echo "Run this script on ALL nodes (master & workers)."
echo "-----------------------------"



# Step 2: Initialize Master Node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml


