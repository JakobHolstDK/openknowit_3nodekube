#!/usr/bin/env bash

curl -fsSL https://download.docker.com/linux/ubuntu/gpg > /etc/apt/trusted.gpg.d/docker.gpg
sudo apt install -y software-properties-common
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu    $(lsb_release -cs)    stable"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg > /etc/apt/trusted.gpg.d/google.gpg
sudo apt-get update

exit

sudo apt-get install -y docker-ce kubelet kubeadm kubectl
sudo apt-mark hold docker-ce kubelet kubeadm kubectl
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sudo kubeadm join [your unique string from the kubeadm init command]
kubectl get nodes
kubectl run busybox --image=busybox:1.28.4 --generator=run-pod/v1 --command -- sleep 99999
kubectl exec busybox -- cat /etc/resolv.conf
kubectl exec busybox -- nslookup kubernetes
