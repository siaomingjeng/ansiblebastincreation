#!/usr/bin/env bash

echo 'Install EPEL repo'
yum install -y epel-release git expect
yum update -y
echo -e '\033[35;5m Stop SSH Host Key Checking . . . \033[0m'
sudo sed -i 's/#.*StrictHostKeyChecking .*/StrictHostKeyChecking no/' /etc/ssh/ssh_config

echo "Install Azure CLI"
# Import the Microsoft repository key.
rpm --import https://packages.microsoft.com/keys/microsoft.asc
# Create local azure-cli repository information.
sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
# Install with the yum install command.
yum install azure-cli -y

echo "Install kubectl"
# Install kubectl using az cli. Other installation does not work here.
az aks install-cli
sed -i 's/PATH=$PATH:$HOME\/bin/PATH=$PATH:$HOME\/bin:\/usr\/local\/bin/g' ~/.bash_profile
. ~/.bash_profile
kubectl completion bash > /etc/bash_completion.d/kubectl

echo "Instal kubectx and kubens"
curl -Lo /usr/local/bin/kubens https://raw.githubusercontent.com/siaomingjeng/kubectx/master/kubens
curl -Lo /usr/local/bin/kubectx https://raw.githubusercontent.com/siaomingjeng/kubectx/master/kubectx
chmod +x /usr/local/bin/kubens /usr/local/bin/kubectx
curl -Lo /etc/bash_completion.d/kubens https://raw.githubusercontent.com/siaomingjeng/kubectx/master/completion/kubens.bash
curl -Lo /etc/bash_completion.d/kubectx https://raw.githubusercontent.com/siaomingjeng/kubectx/master/completion/kubectx.bash

# link kubectl to k:
ln -sf kubectl /usr/local/bin/k
kubectl completion bash > /etc/bash_completion.d/k
sed -i 's/-F __start_kubectl kubectl/-F __start_kubectl k/g' /etc/bash_completion.d/k

echo "source completion"
## Enable completion: completion is installed at /etc/bash_completion.d/azure-cli
source /etc/bash_completion.d/azure-cli /etc/bash_completion.d/kubens /etc/bash_completion.d/kubectx /etc/bash_completion.d/kubectl /etc/bash_completion.d/k

echo -e '\033[35;5m  Install PostgreSQL12 client . . . \033[0m'
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install -y postgresql12

echo "Install Python-pip and install Ansible in an Virtual ENV, in case Ansible conflicts with Azure CLI"
## need to change after Jan1st 2020
yum install python-pip -y
pip install virtualenv
virtualenv ansible
source ansible/bin/activate
pip install --upgrade pip
pip install ansible[azure]
deactivate
