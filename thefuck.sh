#!/bin/bash

if ! command -v fuck &>/dev/null; then
  echo "Installing thefuck from Fedora repositories..."
  
  # Try to install from Fedora repos first
  if sudo dnf install -y thefuck 2>/dev/null; then
    echo "thefuck installed from Fedora repos"
  else
    echo "thefuck not available in Fedora repos, trying alternative installation..."
    
    # Install pipx for better isolation
    sudo dnf install -y pipx
    pipx install thefuck
    
    # Ensure pipx binaries are in PATH
    pipx ensurepath
  fi
  
  echo ""
  echo "To enable thefuck, add this to your shell profile (~/.bashrc):"
  echo "eval \$(thefuck --alias)"
  echo "Then restart your shell or run: source ~/.bashrc"
fi
