cd
exit
cd
vi app-deployment
vi mysql-configmap.yaml
vi mysql-secret.yaml
kubectl apply -f mysql-secret.yaml
vi mysql-secret.yaml
kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql-configmap.yaml 
kubectl apply -f app-deployment 
cat app-deployment 
vi app-deployment 
kubectl apply -f app-deployment 
kebuctl get all
kebuctl get all po
kebectl get all po
kebectl get all
kubectl get all
cat app-deployment 
vi mysql-deployment.yaml
kubectl apply -f mysql-deployment.yaml
kubectl get all
vi mysql-deployment.yaml
kubectl apply -f mysql-deployment.yaml
kubectl get all
cd
vi pods
kubectl apply -f pods
kubectl get po
kubectl describe pod nginx-pod
kubectl exec -it nginx-pod -- /bin/bash
kubectl get po
cd
# Update packages
sudo apt update -y
sudo apt upgrade -y
# Disable swap (Kubernetes doesn’t support swap)
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
# Enable required kernel modules
sudo modprobe overlay
sudo modprobe br_netfilter
# Add kernel settings
cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply the settings
sudo sysctl --system
# Install containerd
sudo apt install -y containerd
# Generate default config file
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
# Edit config.toml: use systemd as cgroup driver
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
# Restart containerd
sudo systemctl restart containerd
sudo systemctl enable containerd
# Add Kubernetes repository
sudo apt install -y apt-transport-https ca-certificates curl gpg
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# Install components
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
# Prevent automatic updates
sudo apt-mark hold kubelet kubeadm kubectl
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
kubectl get nodes
kubectl get pods -A
kubectl get nodes
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl get nodes
cd
kubectl get pods
cat pods
vi pods
kubectl apply -f pods
kubectl cerate ns nginx
kubectl create ns nginx
kubectl apply -f pods
kubectl get po
kubectl delete pod mginx-pod
kubectl delete pod nginx-pod
kubectl apply -f pods
kubectl apply -f pod
lss
ls
lscat pods
cat pods
kubectl appy -f pods
kubectl apply -f pods
vi pods
kubectl apply -f pods
vi pods
kubectl apply -f pods
kubectl get po
kubectl get po -n nginx
kubectl describe pod nginx-pod -n nginx
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl describe pod nginx-pod -n nginx
kubectl get po -n nginx
vi deployment.yaml
kubectl apply -f deployment.yaml 
kubectl get all -n nginx
vi PersistentVolume.yaml
kubectl apply -d PersistentVolume.yaml 
kubectl apply -f PersistentVolume.yaml 
vi PersistentVolume
kubectl apply -f PersistentVolume
cat PersistentVolume.yaml 
vi PersistentVolumeClaim
cat PersistentVolumeClaim
kubectl apply -f PersistentVolumeClaim 
vi Deployment-1
kubectl apply -f Deployment-1 
kubectl get all -n nginx
vi service.yaml
kubectl apply -f service.yaml 
kubectl get all -n nginx
kubectl port-forward service/nginx-service 8080:80 -n nginx --address 0.0.0.0
