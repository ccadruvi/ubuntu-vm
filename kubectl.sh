#!/bin/bash
set -uo pipefail

if ! command -v kubectl &> /dev/null ; then
  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
EOF
 
  sudo dnf install -y kubectl
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
