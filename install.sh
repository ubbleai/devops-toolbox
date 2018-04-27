#!/bin/bash

apt-get install -y vim curl wget dnsutils procps jq python python-pip git unzip

pip install -U awscli

# Kubectl
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubectl

# kops
wget https://github.com/kubernetes/kops/releases/download/1.8.0/kops-linux-amd64
chmod +x kops-linux-amd64
mv kops-linux-amd64 /usr/local/bin/kops

# vault
rm -f vault*
wget https://releases.hashicorp.com/vault/0.10.1/vault_0.10.1_linux_amd64.zip
unzip vault_0.10.1_linux_amd64.zip
mv vault /usr/local/bin/

mkdir -p /var/lib

pushd /var/lib

git clone https://github.com/gobadiah/devops-toolbox

ln -s /var/lib/devops-toolbox/bin/* /usr/local/bin/

popd
