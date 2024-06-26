#!/bin/bash
set -euo pipefail

# Instructions at
# https://signal.org/en/download/linux/

if ! command -v signal-desktop &> /dev/null; then
  wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
  cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
  
  # 2. Add our repository to your list of repositories
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
    sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
  rm -f signal-desktop-keyring.gpg
  
  # 3. Update your package database and install signal
  sudo apt update && sudo apt install signal-desktop
else
  echo "already installed"
fi
