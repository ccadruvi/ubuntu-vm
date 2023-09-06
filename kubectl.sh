#!/bin/bash
set -uo pipefail

if ! command -v kubectl &> /dev/null ; then
  mkdir -p /etc/apt/keyrings
  sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list  
 
  sudo apt-get update
  sudo apt-get install -y kubectl
fi


if ! command -v kubectx &> /dev/null; then
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
  sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

  git clone https://github.com/ahmetb/kubectx.git ~/.kubectx
  COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
  sudo ln -sf ~/.kubectx/completion/kubens.bash $COMPDIR/kubens
  sudo ln -sf ~/.kubectx/completion/kubectx.bash $COMPDIR/kubectx
fi
