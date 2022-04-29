#!/bin/bash
set -uo pipefail

if ! command -v code &> /dev/null; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  
  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install code
  extensions="""cfgweb.vscode-perl
DavidAnson.vscode-markdownlint
DotJoshJohnson.xml
foxundermoon.shell-format
golang.go
hashicorp.terraform
justin-grote.better-powershell-syntax-highlighting
mechatroner.rainbow-csv
ms-azuretools.vscode-docker
ms-dotnettools.csharp
ms-vscode.azure-account
ms-vscode.powershell
nico-castell.linux-desktop-file
NicolasVuillamy.vscode-groovy-lint
redhat.vscode-yaml
timonwong.shellcheck
VisualStudioExptTeam.vscodeintellicode
"""
  echo "$extensions" | xargs -n 1 code --install-extension

  mkdir -p ~/.config/Code/User
  cp ./vscode-settings.json ~/.config/Code/User/settings.json
fi 
