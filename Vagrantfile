# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<-SCRIPT
wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
tar -xzf go1.19.1.linux-amd64.tar.gz
mv go /usr/local/
rm -rf go1.19.1.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
apt-get install gcc -y
echo "--- Instalando minikube ---"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
echo "alias kubectl='minikube kubectl --'" >> /etc/profile
SCRIPT

$minikube = <<-SCRIPT
minikube config set driver docker
minikube start -n 3
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "kubernetes-lab"
    vb.memory = "6144"
    vb.cpus = 4
  end
  config.vm.provision "docker" do |d|
    d.pull_images "alpine:3.16.2"
  end

  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", inline: $minikube, privileged: false
end
