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
  
  # Install bash-completion if not present
  if ! rpm -q bash-completion &> /dev/null; then
    sudo dnf install -y bash-completion
  fi
  
  # Set completion directory - try pkg-config first, fallback to standard location
  COMPDIR=$(pkg-config --variable=completionsdir bash-completion 2>/dev/null || echo "/usr/share/bash-completion/completions")
  
  # Ensure completion directory exists
  sudo mkdir -p "$COMPDIR"
  
  sudo ln -sf ~/.kubectx/completion/kubens.bash "$COMPDIR"/kubens
  sudo ln -sf ~/.kubectx/completion/kubectx.bash "$COMPDIR"/kubectx
fi
