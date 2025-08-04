#!/bin/bash
set -euo pipefail

# For Fedora, Signal is available via Flatpak or third-party repos
# Using Flatpak for simplicity

if ! command -v signal-desktop &> /dev/null; then
  # Install flatpak if not available
  if ! command -v flatpak &> /dev/null; then
    sudo dnf install -y flatpak
  fi
  
  # Add flathub repo if not already added
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  
  # Install Signal
  flatpak install -y flathub org.signal.Signal
else
  echo "already installed"
fi
