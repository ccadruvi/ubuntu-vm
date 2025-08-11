#!/bin/bash
set -uo pipefail

if ! command -v code &> /dev/null; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  
  sudo dnf check-update
  sudo dnf install code
  extensions="cfgweb.vscode-perl
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
github.copilot
ms-vscode-remote.vscode-remote-extensionpack"
  echo "$extensions" | xargs -n 1 code --install-extension
  echo "If you want to copy vscode settings too, remove the exit here"
  exit 0
  mkdir -p ~/.config/Code/User
  cp ./vscode-settings.json ~/.config/Code/User/settings.json
fi 
