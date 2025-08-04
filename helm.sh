#!/bin/bash
set -euo pipefail

if ! command -v helm &> /dev/null; then
  echo "Installing Helm via official script method..."
  
  # Use the official Helm installation script
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  rm get_helm.sh
fi

echo "Helm is installed"
