#!/bin/bash

####################################
# script to install and configurin k8s on MASTER NODE using new repos from pkgs.k8s.io as of MARCH 2024
####################################

sudo su 
apt update && sudo apt upgrade -y

apt install docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker $USER

exit
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

sudo su 
apt update
apt install kubeadm kubelet kubectl
apt-mark hold kubelet kubeadm kubectl

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
kubeadm init

exit
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
