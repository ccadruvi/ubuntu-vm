#!/bin/bash
set -euo pipefail

if ! command -v fernseh &> /dev/null; then
  sudo apt-get update && sudo apt-get install -y flatpak
  sudo flatpak install flathub org.gnome.NetworkDisplays
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub org.gnome.NetworkDisplays
fi

