#!/bin/bash
set -uo pipefail

if ! command -v terraform &> /dev/null; then
  # Add HashiCorp repository manually
  sudo tee /etc/yum.repos.d/hashicorp.repo > /dev/null <<EOF
[hashicorp]
name=Hashicorp Stable - \$basearch
baseurl=https://rpm.releases.hashicorp.com/fedora/\$releasever/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://rpm.releases.hashicorp.com/gpg
EOF
  
  sudo dnf install -y terraform
fi
