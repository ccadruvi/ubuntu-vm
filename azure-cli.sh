#!/bin/bash

versioncheck () {
        if [ -f "/etc/yum.repos.d/azure-cli.repo" ] ; then
                echo "azure cli is already installed"
                exit 0
        fi
}

versioncheck

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf install -y ca-certificates curl gnupg
echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
sudo dnf install azure-cli
