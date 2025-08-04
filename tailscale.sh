#!/bin/bash
set -euo pipefail

if ! command -v tailscale &> /dev/null; then
  echo "Installing Tailscale..."
  
  # Add Tailscale repository manually
  sudo curl -fsSL https://pkgs.tailscale.com/stable/fedora/tailscale.repo -o /etc/yum.repos.d/tailscale.repo
  
  # Install Tailscale
  sudo dnf install -y tailscale
  
  # Enable and start the service
  sudo systemctl enable --now tailscaled
  
  echo "Tailscale installed and service started"
  echo "Run 'sudo tailscale up' to connect this machine to your tailnet"
else
  echo "Tailscale is already installed"
fi