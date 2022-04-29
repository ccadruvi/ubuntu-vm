#!/bin/bash
set -uo pipefail

if ! command -v kubectl &> /dev/null ; then

  sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
  
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  
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
